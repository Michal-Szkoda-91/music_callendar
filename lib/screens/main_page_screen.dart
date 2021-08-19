import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/music_day_event.dart';
import '../screens/settings_screen.dart';
import '../widgets/table_callendar.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _loadData().then((value) {
        setState(() {
          _isLoaded = true;
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
              color: Theme.of(context).textTheme.headline1!.color,
            ),
          ),
          backgroundColor: Theme.of(context).accentColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
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
