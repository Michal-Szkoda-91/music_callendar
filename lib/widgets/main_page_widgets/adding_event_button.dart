import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';

import '../../models/music_day_event.dart';
import '../../screens/music_event_adding_screen.dart';

class AddingEventButton extends StatelessWidget {
  final DateTime dateTime;

  const AddingEventButton({Key? key, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      clipBehavior: Clip.antiAlias,
      onPressed: () => _navigatorToAddingScreen(context),
      icon: Icon(
        CommunityMaterialIcons.violin,
        size: 30,
        color: Theme.of(context).colorScheme.secondary,
      ),
      label: Text(
        tr("StartGame"),
        style: TextStyle(
          fontSize: 25,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  void _navigatorToAddingScreen(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => MusicEventAddingScreen(
          dateTime: dateTime,
          musicEvent: MusicEvent(
            id: '',
            playTime: 0,
            generalTime: 0,
            targetTime: 1200,
            note: '',
          ),
        ),
      ),
    );
  }
}
