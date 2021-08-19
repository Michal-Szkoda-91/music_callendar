import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel {
  double waitForRecordTime;
  double waitForStopRecordTime;

  SettingsModel({
    required this.waitForRecordTime,
    required this.waitForStopRecordTime,
  });
}

class SettingProvider with ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late SettingsModel _settingModel;

  SettingsModel get settingModel {
    return _settingModel;
  }

  Future<void> loadSetting() async {
    final SharedPreferences prefs = await _prefs;
    double recodTime = prefs.getDouble('waitForRecordTime') ?? 0.12;
    double silenceTime = prefs.getDouble('waitForStopRecordTime') ?? 0.12;
    _settingModel = SettingsModel(
        waitForRecordTime: recodTime, waitForStopRecordTime: silenceTime);
  }

  Future<void> setWaitRecordTime(double waitTime) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setDouble('waitForRecordTime', waitTime);
    loadSetting();
    notifyListeners();
  }

  Future<void> setWaitStopRecordTime(double waitTime) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setDouble('waitForStopRecordTime', waitTime);
    loadSetting();
    notifyListeners();
  }
}
