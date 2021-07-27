import 'package:flutter/material.dart';

import '../widgets/buidler_callendar_container.dart';

class DefaultBuilder extends StatelessWidget {
  const DefaultBuilder({
    Key? key,
    required this.day,
  }) : super(key: key);

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return BuilderCallendarContainer(
      color: Colors.grey,
      child: Center(),
      day: day,
    );
  }
}
