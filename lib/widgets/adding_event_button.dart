import 'package:flutter/material.dart';
import 'package:music_callendar/screens/music_event_adding_screen.dart';

class AddingEventButton extends StatelessWidget {
  final DateTime dateTime;

  const AddingEventButton({Key? key, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _navigatorToAddingScreen(context),
      icon: Icon(
        Icons.headphones,
        size: 30,
      ),
      label: Text("Rozpocznij Grę"),
      style: TextButton.styleFrom(
        textStyle: TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }

  void _navigatorToAddingScreen(BuildContext ctx) {
    Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (context) => MusicEventAddingScreen(dateTime: dateTime)));
  }
}