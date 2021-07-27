import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:music_callendar/screens/main_page_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pl', 'PL'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.grey[300],
          backgroundColor: Colors.blueGrey[400],
          accentColor: Colors.purple[300],
          textTheme: TextTheme(
              headline1: TextStyle(
            color: Colors.white,
          ),),),
      home: MainPage(),
    );
  }
}
