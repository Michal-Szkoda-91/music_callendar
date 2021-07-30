import 'package:flutter/material.dart';
import 'package:music_callendar/models/option_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/table_callendar.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Option _option = new Option();
  late String firstDay;

  Future<void> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _option
        .createFirstDay()
        .then((value) => firstDay = prefs.getString('firstDay')!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Muzyczny Kalendarz",
            style: TextStyle(
              color: Theme.of(context).textTheme.headline1!.color,
            ),
          ),
          backgroundColor: Theme.of(context).accentColor,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot<void> snap) {
            switch (snap.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading....');
              default:
                return Center(
                  child: Column(
                    children: [
                      CustomTableCalendar(
                        firstDay: firstDay,
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
