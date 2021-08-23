import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/brighnes_icon.dart';
import '../../widgets/settings_screen_widgets/policy.dart';
import '../../widgets/settings_screen_widgets/silence_time_setting.dart';
import '../../widgets/settings_screen_widgets/record_time_setting.dart';
import '../../widgets/settings_screen_widgets/autosave.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BrightnessIcon(),
            const SizedBox(width: 12),
          ],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            tr("Settings"),
            style: TextStyle(
              color: Theme.of(context).textTheme.headline1!.color,
            ),
          ),
          backgroundColor: Theme.of(context).accentColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              RecordTimeSetting(),
              StopRecordTimeSetting(),
              AutosaveSetting(),
              PolicyPrivacySetting(),
            ],
          ),
        ),
      ),
    );
  }
}
