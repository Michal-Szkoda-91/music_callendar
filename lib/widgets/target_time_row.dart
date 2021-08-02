import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TargetTimeRow extends StatefulWidget {
  TargetTimeRow({Key? key}) : super(key: key);

  @override
  _TargetTimeRowState createState() => _TargetTimeRowState();
}

class _TargetTimeRowState extends State<TargetTimeRow> {
  var targetPlayTime = Duration(minutes: 20);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Cel:',
                style: _customStyle(),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: _showTimePicker,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${targetPlayTime.toString().split(".")[0]}',
                      style: _customStyle(),
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

  TextStyle _customStyle() {
    return TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );
  }

  void _showTimePicker() {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          children: [
            Text(
              'Ustaw długość dzisiejszej gry',
              style: _customStyle(),
              textAlign: TextAlign.center,
            ),
            CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hms,
              initialTimerDuration: Duration(minutes: 20),
              onTimerDurationChanged: (value) {
                setState(() {
                  targetPlayTime = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Zapisz",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    "Anuluj",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
