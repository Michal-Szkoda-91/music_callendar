import 'package:flutter/material.dart';

import '../widgets/buidler_callendar_container.dart';

class TodayBuilder extends StatelessWidget {
  const TodayBuilder({
    Key? key,
    required this.day,
  }) : super(key: key);

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return BuilderCallendarContainer(
      color: Colors.blueAccent,
      day: day,
      child: Center(),
    );
  }
}
