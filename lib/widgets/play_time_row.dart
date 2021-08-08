// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:record/record.dart';

// import '../models/music_day_provider.dart';
import 'dart:async';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:music_callendar/models/music_day_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

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
  double _equalizeSize = 100;
  int _silenceCounter = 0;
  int _recordCounter = 0;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Czas gry \nna instrumencie:',
                style: _customStyleSmall(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                child: Text(
                  '${actualPlayTime.toString().split(".")[0]}',
                  style: _customStyleBig(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Całkowity czas:',
                style: _customStyleSmall(),
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
          Container(
            width: double.infinity,
            height: 260,
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              height: _equalizeSize,
              width: _equalizeSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  stops: [_isRecording ? 0.8 : 0.3, 1],
                  colors: [
                    _isRecording ? Colors.red : Colors.redAccent,
                    Colors.white,
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  !_isRecording
                      ? CommunityMaterialIcons.music_off
                      : CommunityMaterialIcons.music,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _customStyleSmall() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle _customStyleBig() {
    return TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.bold,
      color: _isRecording ? Colors.black : Colors.grey[350],
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
        if (_amplitude != null && _amplitude!.current < -40) {
          _silenceCounter++;
          _recordCounter = 0;
        } else {
          _recordCounter++;
          _silenceCounter = 0;
        }
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
        if (_amplitude != null && _isRecording && _amplitude!.current > -40) {
          _equalizeSize = 250 - (_amplitude!.current * -4);
        } else {
          _equalizeSize = 100;
        }
      });
    });
  }

  void _setDurationStopTimer() {
    _durationStopTimer?.cancel();
    // print("________Silence$_silenceCounter");
    _durationStopTimer = Timer.periodic(Duration(seconds: 3), (Timer t) async {
      if (_silenceCounter > 3) {
        setState(() {
          _isRecording = false;
        });
      }
      _setDurationStopTimer();
    });
  }

  void _setDurationStartTimer() {
    // print("_______Recording$_recordCounter");
    _durationStartTimer?.cancel();
    _durationStartTimer = Timer.periodic(Duration(seconds: 2), (Timer t) async {
      if (_recordCounter > 2) {
        setState(() {
          _isRecording = true;
        });
      }
      _setDurationStartTimer();
    });
  }
}
