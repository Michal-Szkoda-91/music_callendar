import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool _isLoaded = false;
  bool _isInit = true;

  Future<void> _loadData() async {
    await Provider.of<MusicEvents>(context).fetchAndSetEvents();
  }

  Future<void> _loadSetting() async {
    await Provider.of<SettingProvider>(context, listen: false).loadSetting();
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
            "Muzyczny Kalendarz",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          backgroundColor: Theme.of(context).accentColor,
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
