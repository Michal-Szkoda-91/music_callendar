// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:record/record.dart';

// import '../models/music_day_provider.dart';
import 'dart:async';

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
  final _audioRecorder = Record();
  Amplitude? _amplitude;

  @override
  void initState() {
    actualPlayTime = Duration(seconds: widget.playTime);
    generalPlayTime = Duration(seconds: widget.generalTime);
    _isListen = false;
    super.initState();
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MusicProvider>(context, listen: false)
        .setPlayTime(actualPlayTime.inSeconds);
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
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 200,
            ),
            color: Theme.of(context).primaryColor,
          ),
          if (_amplitude != null) ...[
            const SizedBox(height: 40),
            Text('Current: ${_amplitude?.current ?? 0.0}'),
            Text('Max: ${_amplitude?.max ?? 0.0}'),
          ],
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
    );
  }

  void incrasePlayTime() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        actualPlayTime += Duration(seconds: 1);
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
          .setPlayTime(generalPlayTime.inSeconds);
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
        print("START_______SLUCHANIE");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopListen() async {
    _audioRecorder.stop();
    setState(() => _isListen = false);
  }
}
