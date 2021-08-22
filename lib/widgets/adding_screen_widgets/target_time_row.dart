import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/music_day_provider.dart';

class TargetTimeRow extends StatefulWidget {
  final int targetTime;

  const TargetTimeRow({Key? key, required this.targetTime}) : super(key: key);
  @override
  _TargetTimeRowState createState() => _TargetTimeRowState();
}

class _TargetTimeRowState extends State<TargetTimeRow> {
  var targetPlayTime;
  @override
  void initState() {
    targetPlayTime = Duration(seconds: widget.targetTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MusicProvider>(context, listen: false)
        .setTargetTime(targetPlayTime.inSeconds);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Cel:',
                style: _customStyleSmall(),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  _showTimePicker(targetPlayTime);
                },
                child: Card(
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${targetPlayTime.toString().split(".")[0]}',
                      style: _customStyleBig(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _customStyleSmall() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).textTheme.headline1!.color,
    );
  }

  TextStyle _customStyleBig() {
    return TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.headline1!.color,
    );
  }

  void _showTimePicker(var actualDuration) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
            backgroundColor: Theme.of(context).backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Ustaw planowaną na dziś długość gry na instrumencie',
                    style: _customStyleSmall(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  CupertinoTheme(
                    data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                            textStyle: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color,
                    ))),
                    child: CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hms,
                      initialTimerDuration: actualDuration,
                      onTimerDurationChanged: (value) {
                        setState(() {
                          targetPlayTime = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              targetPlayTime = actualDuration;
                            });
                            Navigator.of(ctx).pop();
                          },
                          child: Text(
                            "Anuluj",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            //Providers
                            Provider.of<MusicProvider>(context, listen: false)
                                .setTargetTime(targetPlayTime.inSeconds);
                          },
                          child: Text(
                            "Zapisz",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
