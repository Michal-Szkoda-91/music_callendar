import 'package:flutter/material.dart';

import '../globalMethods/global_methods.dart';
import '../models/music_day_event.dart';
import '../widgets/buidler_callendar_container.dart';

class HolidayBuilder extends StatelessWidget {
  HolidayBuilder({
    Key? key,
    required this.day,
  }) : super(key: key);

  final DateTime day;
  final GlobalMethods globalMethods = GlobalMethods();
  @override
  Widget build(BuildContext context) {
    // Face face = globalMethods.setFace(
    //     targetTime: event.targetTime, playTime: event.playTime);
    return BuilderCallendarContainer(
      color: Colors.red,
      day: day,
      child: Center(
        // child: Icon(
        //   face.icon,
        //   color: face.color,
        // ),
      ),
    );
  }
}
