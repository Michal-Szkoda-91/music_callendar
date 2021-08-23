import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/theme_providers.dart';
import '/models/music_day_event.dart';
import '/models/setting_providers.dart';
import '/models/music_day_provider.dart';
import '/screens/main_page_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        Locale('pl'),
        Locale('en'),
        Locale('de'),
        Locale('es'),
      ],
      fallbackLocale: Locale('en'),
      path: 'assets/langs',
    ),
  );
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
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
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
