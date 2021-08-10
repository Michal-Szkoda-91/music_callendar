import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../models/music_day_provider.dart';
import 'actual_play_time_row.dart';
import 'eqalizer.dart';
import 'sensitive_slider.dart';

class PlayTimeRow extends StatefulWidget {
  final int playTime;
  final int generalTime;

  const PlayTimeRow(
      {Key? key, required this.playTime, required this.generalTime})
      : super(key: key);
  @override
  _PlayTimeRowState createState() => _PlayTimeRowState();
}

class _PlayTimeRowState extends State<PlayTimeRow> {
  late Duration actualPlayTime;
  late Duration generalPlayTime;
  bool _isListen = false;
  bool _isRecording = false;
  final _audioRecorder = Record();
  Amplitude? _amplitude;
  double _equalizeSize = 80;
  double _silenceCounter = 0;
  double _recordCounter = 0;

  Timer? _ampTimer;
  Timer? _durationStopTimer;
  Timer? _durationStartTimer;

  @override
  void initState() {
    actualPlayTime = Duration(seconds: widget.playTime);
    generalPlayTime = Duration(seconds: widget.generalTime);
    _isListen = false;
    _isRecording = false;

    super.initState();
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _ampTimer?.cancel();
    _durationStopTimer?.cancel();
    _durationStartTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MusicProvider>(context, listen: false)
        .setPlayTime(actualPlayTime.inSeconds);
    Provider.of<MusicProvider>(context, listen: false)
        .setGeneralTime(generalPlayTime.inSeconds);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          ActualPlayTimeRow(
              actualPlayTime: actualPlayTime, isRecording: _isRecording),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Całkowity czas:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 20),
              !_isListen
                  ? InkWell(
                      child: Icon(Icons.play_arrow,
                          size: 45, color: Theme.of(context).accentColor),
                      onTap: startListen,
                    )
                  : InkWell(
                      child: Icon(Icons.stop,
                          size: 45, color: Theme.of(context).accentColor),
                      onTap: _stopListen,
                    ),
              const SizedBox(width: 20),
              Text(
                '${generalPlayTime.toString().split(".")[0]}',
                style: TextStyle(
                    fontSize: 20,
                    color: _isListen ? Colors.black : Colors.grey[350]),
              ),
            ],
          ),
          Row(
            children: [
              Equalizer(equalizeSize: _equalizeSize, isRecording: _isRecording),
              SensitiveSlider(),
            ],
          ),
        ],
      ),
    );
  }

  void incrasePlayTime() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        if (_isRecording) {
          actualPlayTime += Duration(seconds: 1);
        }
      });
      Provider.of<MusicProvider>(context, listen: false)
          .setPlayTime(actualPlayTime.inSeconds);
      if (_isListen) incrasePlayTime();
    });
  }

  void incraseGeneralTime() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        generalPlayTime += Duration(seconds: 1);
      });
      Provider.of<MusicProvider>(context, listen: false)
          .setGeneralTime(generalPlayTime.inSeconds);
      if (_isListen) incraseGeneralTime();
    });
  }

  Future<void> startListen() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();
        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isListen = isRecording;
        });
        incraseGeneralTime();
        incrasePlayTime();
        _setApmTimer();
        _setDurationStopTimer();
        _setDurationStartTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopListen() async {
    _audioRecorder.stop();
    _ampTimer?.cancel();
    _durationStartTimer?.cancel();
    _durationStopTimer?.cancel();
    setState(() {
      _isListen = false;
      _isRecording = false;
      _equalizeSize = 100;
      _silenceCounter = 0;
      _recordCounter = 0;
    });
  }

  void _setApmTimer() {
    _ampTimer?.cancel();
    _ampTimer =
        Timer.periodic(const Duration(milliseconds: 150), (Timer t) async {
      _amplitude = await _audioRecorder.getAmplitude();
      setState(() {
        //animation controler
        if (_amplitude != null &&
            _amplitude!.current >
                -(30 +
                    Provider.of<MusicProvider>(context, listen: false)
                        .sensitive)) {
          _equalizeSize = 250 - (_amplitude!.current * -4);
        } else {
          _equalizeSize = 80;
        }
      });
      if (_amplitude != null &&
          _amplitude!.current >
              -(30 +
                  Provider.of<MusicProvider>(context, listen: false)
                      .sensitive)) {
        _recordCounter += 0.15;
        _silenceCounter = 0;
      } else {
        _silenceCounter += 0.15;
        _recordCounter = 0;
      }
    });
  }

  void _setDurationStopTimer() {
    _durationStopTimer?.cancel();
    _durationStopTimer = Timer.periodic(Duration(seconds: 2), (Timer t) async {
      if (_silenceCounter > 3) {
        setState(() {
          _isRecording = false;
        });
      }
      _setDurationStopTimer();
    });
  }

  void _setDurationStartTimer() {
    _durationStartTimer?.cancel();
    _durationStartTimer = Timer.periodic(Duration(seconds: 3), (Timer t) async {
      if (_recordCounter > 3) {
        setState(() {
          _isRecording = true;
        });
      }
      _setDurationStartTimer();
    });
  }
}
