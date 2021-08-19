import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '/models/music_day_event.dart';
import '/models/setting_providers.dart';
import '/models/music_day_provider.dart';
import '/screens/main_page_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicProvider()),
        ChangeNotifierProvider(create: (_) => MusicEvents()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('pl', 'PL'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Music Callendar',
        theme: ThemeData(
          primaryColor: Colors.grey[100],
          backgroundColor: Colors.purple[50],
          accentColor: Colors.purple[400],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.purple[300],
          ),
          textTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.white,
            ),
            headline2: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        home: MainPage(),
      ),
    );
  }
}
