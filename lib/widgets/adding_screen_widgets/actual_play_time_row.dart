import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActualPlayTimeRow extends StatelessWidget {
  const ActualPlayTimeRow({
    Key? key,
    required this.actualPlayTime,
    required bool isRecording,
  })  : _isRecording = isRecording,
        super(key: key);

  final Duration actualPlayTime;
  final bool _isRecording;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width * 0.45
              : MediaQuery.of(context).size.width * 0.2,
          child: Text(
            tr("InstrumentPlayTime"),
            overflow: TextOverflow.visible,
            softWrap: true,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width * 0.55
              : MediaQuery.of(context).size.width * 0.25,
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          child: Text(
            '${actualPlayTime.toString().split(".")[0]}',
            style: TextStyle(
              fontSize:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 35
                      : 25,
              fontWeight: FontWeight.bold,
              color: _isRecording
                  ? Theme.of(context).textTheme.headline1!.color
                  : Theme.of(context).cardColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
