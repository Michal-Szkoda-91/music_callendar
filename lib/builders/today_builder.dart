import 'package:flutter/material.dart';

class TodayBuilder extends StatelessWidget {
  const TodayBuilder({
    Key? key,
    required this.day,
  }) : super(key: key);

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0.5),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Text(
        day.day.toString(),
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
