import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProviders extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
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

  static final lightTheme = ThemeData();
}
