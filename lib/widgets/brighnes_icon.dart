import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/theme_providers.dart';

class BrightnessIcon extends StatefulWidget {
  BrightnessIcon({Key? key}) : super(key: key);

  @override
  _BrightnessIconState createState() => _BrightnessIconState();
}

class _BrightnessIconState extends State<BrightnessIcon> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProviders>(context);
    return GestureDetector(
      onTap: () {
        themeProvider.toggleTheme(!themeProvider.isDarkMode);
      },
      child: Icon(
        themeProvider.isDarkMode
            ? CommunityMaterialIcons.brightness_4
            : CommunityMaterialIcons.brightness_5,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
