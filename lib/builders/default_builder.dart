import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globalMethods/global_methods.dart';
import '../models/music_day_event.dart';
import '../widgets/buidler_callendar_container.dart';

class DefaultBuilder extends StatefulWidget {
  DefaultBuilder({
    Key? key,
    required this.day,
  }) : super(key: key);

  final DateTime day;

  @override
  _DefaultBuilderState createState() => _DefaultBuilderState();
}

class _DefaultBuilderState extends State<DefaultBuilder> {
  final GlobalMethods globalMethods = GlobalMethods();

  MusicEvent event = MusicEvent(id: '', playTime: 0, targetTime: 0, generalTime: 0, note: '');

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<MusicEvents>(context, listen: false);
    try {
      event = data.findById(DateFormat.yMd('pl_PL').format(widget.day));
    } catch (e) {}

    Face face = globalMethods.setFace(
        targetTime: event.targetTime, playTime: event.playTime);
    return BuilderCallendarContainer(
      color: Colors.grey,
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
