import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/target_time_row.dart';
import '../widgets/note_floating_act_bar.dart';
import '../widgets/play_time_row.dart';

class MusicEventAddingScreen extends StatefulWidget {
  final DateTime dateTime;
  MusicEventAddingScreen({Key? key, required this.dateTime}) : super(key: key);

  @override
  _MusicEventAddingScreenState createState() => _MusicEventAddingScreenState();
}

class _MusicEventAddingScreenState extends State<MusicEventAddingScreen> {
  late String _appBarDate;
  @override
  void initState() {
    super.initState();
    _appBarDate = DateFormat.MMMMEEEEd('pl_PL').format(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).textTheme.headline1!.color,
          ),
          title: Text(
            _appBarDate,
            style: TextStyle(
              color: Theme.of(context).textTheme.headline1!.color,
            ),
          ),
          backgroundColor: Theme.of(context).accentColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TargetTimeRow(),
              PlayTimeRow(),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: 200,
                ),
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
        floatingActionButton: NoteFloatingBar(),
      ),
    );
  }
}
