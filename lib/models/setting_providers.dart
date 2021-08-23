import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel {
  double waitForRecordTime;
  double waitForStopRecordTime;
  bool? autoSaveIsOn;

  SettingsModel({
    required this.waitForRecordTime,
    required this.waitForStopRecordTime,
    required this.autoSaveIsOn,
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
    bool? autoSave = prefs.getBool('autoSaveIsOn') ?? true;
    _settingModel = SettingsModel(
        waitForRecordTime: recodTime,
        waitForStopRecordTime: silenceTime,
        autoSaveIsOn: autoSave);
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

  Future<void> setAutoSave(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('autoSaveIsOn', value);
    loadSetting();
    notifyListeners();
  }
}
