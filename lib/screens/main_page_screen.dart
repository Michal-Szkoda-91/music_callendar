import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';

import '../widgets/brighnes_icon.dart';
import '../models/setting_providers.dart';
import '../models/music_day_event.dart';
import '../screens/settings_screen.dart';
import '../widgets/main_page_widgets/table_callendar.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //Check actual Version
  final newVersion = NewVersion(); //Have to pass String with android ID

  bool _isLoaded = false;
  bool _isInit = true;

  Future<void> _loadData() async {
    await Provider.of<MusicEvents>(context).fetchAndSetEvents();
  }

  Future<void> _loadSetting() async {
    await Provider.of<SettingProvider>(context, listen: false).loadSetting();
  }

  Future<void> _checkVersion(BuildContext context) async {
    final status = await newVersion.getVersionStatus();
    if (status!.canUpdate) {
      newVersion.showAlertIfNecessary(context: context);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkVersion(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _loadData().then((value) {
        _loadSetting().then((value) {
          setState(() {
            _isLoaded = true;
          });
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BrightnessIcon(),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {
                _navigateToSettings(context);
              },
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
          title: Text(
            tr('title'),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: !_isLoaded ? Center() : CustomTableCalendar(),
      ),
    );
  }

  void _navigateToSettings(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(),
      ),
    );
  }
}
