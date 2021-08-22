import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globalMethods/global_methods.dart';
import '../models/music_day_event.dart';
import '../widgets/main_page_widgets/buidler_callendar_container.dart';

class HolidayBuilder extends StatefulWidget {
  HolidayBuilder({
    Key? key,
    required this.day,
  }) : super(key: key);

  final DateTime day;

  @override
  _HolidayBuilderState createState() => _HolidayBuilderState();
}

class _HolidayBuilderState extends State<HolidayBuilder> {
  final GlobalMethods globalMethods = GlobalMethods();

  MusicEvent event =
      MusicEvent(id: '', playTime: 0, generalTime: 0, targetTime: 0, note: '');

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<MusicEvents>(context, listen: false);
    try {
      event = data.findById(DateFormat.yMd('pl_PL').format(widget.day));
    } catch (e) {}
    Face face = globalMethods.setFace(
      targetTime: event.targetTime,
      playTime: event.playTime,
      context: context,
    );
    return BuilderCallendarContainer(
      color: Theme.of(context).errorColor,
      day: widget.day,
      child: event.id == ''
          ? Center()
          : Center(
              child: Icon(
                face.icon,
                color: face.color,
              ),
            ),
    );
  }
}
