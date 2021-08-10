import 'package:flutter/material.dart';

class ActualPlayTimeRow extends StatelessWidget {
  const ActualPlayTimeRow({
    Key? key,
    required this.actualPlayTime,
    required bool isRecording,
  }) : _isRecording = isRecording, super(key: key);

  final Duration actualPlayTime;
  final bool _isRecording;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Czas gry \nna instrumencie:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
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
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: _isRecording ? Colors.black : Colors.grey[350],
            ),
          ),
        ),
      ],
    );
  }
}