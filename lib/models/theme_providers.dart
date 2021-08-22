import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProviders extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool check) {
    themeMode = check ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyDarkLightThemes {
  static final darkTheme = ThemeData(
    primaryColor: Colors.grey[300],
    scaffoldBackgroundColor: Colors.grey.shade800,
    backgroundColor: Colors.grey[600],
    cardColor: Colors.grey.shade700,
    accentColor: Colors.purple[400],
    errorColor: Colors.red.shade300,
    hoverColor: Colors.green.shade300,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.grey[100],
      ),
    ),
  );

  static final lightTheme = ThemeData(
    primaryColor: Colors.grey[900],
    scaffoldBackgroundColor: Colors.grey.shade200,
    backgroundColor: Colors.grey[100],
    cardColor: Colors.grey.shade400,
    accentColor: Colors.purple[300],
    errorColor: Colors.red.shade500,
    hoverColor: Colors.green.shade500,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.grey[800],
      ),
    ),
  );
}
