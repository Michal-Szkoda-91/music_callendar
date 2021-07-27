import 'package:flutter/material.dart';

import '../widgets/buidler_callendar_container.dart';

class HolidayBuilder extends StatelessWidget {
  const HolidayBuilder({
    Key? key,
    required this.day,
  }) : super(key: key);

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return BuilderCallendarContainer(
      color: Colors.red,
      day: day,
      child: Center(),
    );
  }
}
