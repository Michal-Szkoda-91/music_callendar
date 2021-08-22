import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '/models/theme_providers.dart';
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
        ChangeNotifierProvider(create: (_) => ThemeProviders()),
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProviders>(context);
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
          title: 'Music Callendar',
          themeMode: themeProvider.themeMode,
          theme: MyDarkLightThemes.lightTheme,
          darkTheme: MyDarkLightThemes.darkTheme,
          home: MainPage(),
        );
      },
    );
  }
}
