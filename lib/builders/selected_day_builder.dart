import 'package:flutter/material.dart';

import '../widgets/buidler_callendar_container.dart';

class SelectedDayBuilder extends StatelessWidget {
  const SelectedDayBuilder({
    Key? key,
    required this.day,
  }) : super(key: key);

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return BuilderCallendarContainer(
      color: Colors.orange,
      day: day,
      child: Center(),
    );
  }
}
