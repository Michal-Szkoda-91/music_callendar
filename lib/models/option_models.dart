import 'package:shared_preferences/shared_preferences.dart';

class Option {
  ///Function wchich check if app is running first time and then sets SHARED first data;
  Future<void> createFirstDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? result = prefs.getBool('checkIfFirstDayExist');
    if (result == null) {
      DateTime dateTime = DateTime.now();
      String convertedTime = dateTime.toString().substring(0, 10);
      print("Brak pierwszego dnia");
      prefs.setBool('checkIfFirstDayExist', true);
      prefs.setString('firstDay', '$convertedTime');
    } else {
      print("Jest pierwszy dzien");
    }
  }
}
