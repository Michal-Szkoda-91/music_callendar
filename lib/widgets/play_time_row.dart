import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../models/music_day_provider.dart';
import 'actual_play_time_row.dart';
import 'eqalizer.dart';
import 'record_&_silence_slider.dart';
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

  Timer? _ampTimer;
  Timer? _durationStopTimer;
  Timer? _durationStartTimer;
  Timer? _incraseGeneralTime;
  Timer? _incraseActualTime;

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
    _isListen = false;
    _isRecording = false;
    _audioRecorder.dispose();
    _ampTimer?.cancel();
    _durationStopTimer?.cancel();
    _durationStartTimer?.cancel();
    _incraseGeneralTime?.cancel();
    _incraseActualTime?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MusicProvider>(context, listen: false)
        .setPlayTime(actualPlayTime.inSeconds);
    Provider.of<MusicProvider>(context, listen: false)
        .setGeneralTime(generalPlayTime.inSeconds);
    return MediaQuery.of(context).orientation == Orientation.portrait
        ?
        // Portrait MODE
        //
        //
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ActualPlayTimeRow(
                  actualPlayTime: actualPlayTime, isRecording: _isRecording),
              const SizedBox(height: 15),
              _createRowGenerealTime(context),
              Row(
                children: [
                  SensitiveSlider(),
                  Equalizer(
                      equalizeSize: _equalizeSize, isRecording: _isRecording),
                ],
              ),
              RecordSilenceSlider(),
            ],
          )
        :
        //Landscape MODE
        //
        //
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SensitiveSlider(),
                      Equalizer(
                          equalizeSize: _equalizeSize,
                          isRecording: _isRecording),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 30),
              Column(
                children: [
                  ActualPlayTimeRow(
                      actualPlayTime: actualPlayTime,
                      isRecording: _isRecording),
                  const SizedBox(height: 20),
                  _createRowGenerealTime(context),
                  const SizedBox(height: 20),
                  RecordSilenceSlider(),
                ],
              ),
            ],
          );
  }

  Row _createRowGenerealTime(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Całkowity czas:',
          style: TextStyle(
            fontSize: 15,
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
              fontSize: 20, color: _isListen ? Colors.black : Colors.grey[350]),
        ),
      ],
    );
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
    _incraseActualTime?.cancel();
    _incraseGeneralTime?.cancel();
    setState(() {
      _isListen = false;
      _isRecording = false;
      _equalizeSize = 100;
      Provider.of<MusicProvider>(context, listen: false).setSilenceCounter(0);
      Provider.of<MusicProvider>(context, listen: false).setRecordCounter(0);
    });
  }

  void incrasePlayTime() {
    _incraseActualTime?.cancel();
    _incraseActualTime = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isRecording) {
        actualPlayTime += Duration(seconds: 1);
        Provider.of<MusicProvider>(context, listen: false)
            .setPlayTime(actualPlayTime.inSeconds);
      }
    });
  }

  void incraseGeneralTime() {
    _incraseGeneralTime?.cancel();
    _incraseGeneralTime = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        generalPlayTime += Duration(seconds: 1);
        Provider.of<MusicProvider>(context, listen: false)
            .setGeneralTime(generalPlayTime.inSeconds);
      });
    });
  }

  void _setApmTimer() {
    _ampTimer?.cancel();
    _ampTimer =
        Timer.periodic(const Duration(milliseconds: 250), (Timer t) async {
      // Providers
      //
      //
      var silenceData =
          Provider.of<MusicProvider>(context, listen: false).silenceCounter;
      var recordData =
          Provider.of<MusicProvider>(context, listen: false).recordCounter;
      var sensitive =
          Provider.of<MusicProvider>(context, listen: false).sensitive;
      _amplitude = await _audioRecorder.getAmplitude();
      setState(() {
        //animation controler
        if (_amplitude != null && _amplitude!.current > -(30 + sensitive)) {
          _equalizeSize = 250 - (_amplitude!.current * -4);
        } else {
          _equalizeSize = 80;
        }
      });
      if (_amplitude != null && _amplitude!.current > -(30 + sensitive)) {
        if (recordData < 0.95)
          Provider.of<MusicProvider>(context, listen: false)
              .setRecordCounter(recordData += 0.05);
        Provider.of<MusicProvider>(context, listen: false).setSilenceCounter(0);
      } else {
        if (silenceData < 0.95)
          Provider.of<MusicProvider>(context, listen: false)
              .setSilenceCounter(silenceData += 0.15);
        Provider.of<MusicProvider>(context, listen: false).setRecordCounter(0);
      }
    });
  }

  void _setDurationStopTimer() {
    var silenceData =
        Provider.of<MusicProvider>(context, listen: false).silenceCounter;
    _durationStopTimer?.cancel();
    _durationStopTimer =
        Timer.periodic(Duration(milliseconds: 300), (Timer t) async {
      if (silenceData > 0.95) {
        setState(() {
          _isRecording = false;
        });
      }
      _setDurationStopTimer();
    });
  }

  void _setDurationStartTimer() {
    var recordData =
        Provider.of<MusicProvider>(context, listen: false).recordCounter;
    _durationStartTimer?.cancel();
    _durationStartTimer =
        Timer.periodic(Duration(milliseconds: 300), (Timer t) async {
      if (recordData > 0.95) {
        setState(() {
          _isRecording = true;
        });
      }
      _setDurationStartTimer();
    });
  }
}
