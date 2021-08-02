import 'package:flutter/material.dart';

class PlayTimeRow extends StatefulWidget {
  @override
  _PlayTimeRowState createState() => _PlayTimeRowState();
}

class _PlayTimeRowState extends State<PlayTimeRow> {
  double playTime = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Czas gry:',
            style: _customStyle(),
          ),
          const SizedBox(width: 20),
          Text(
            '${playTime.toStringAsFixed(2)}',
            style: _customStyle(),
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
}
