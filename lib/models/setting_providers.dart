import 'package:flutter/cupertino.dart';

class SettingsModel {
  double waitForRecordTime;
  double waitForStopRecordTime;

  SettingsModel({
    required this.waitForRecordTime,
    required this.waitForStopRecordTime,
  });
}

class SettingProvider with ChangeNotifier {}
