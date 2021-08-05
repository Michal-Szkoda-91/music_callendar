import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_callendar/databaseHelper/databaseHelper.dart';
import 'package:music_callendar/models/music_day_event.dart';
import 'package:provider/provider.dart';

import '../models/music_day_provider.dart';
import '../widgets/target_time_row.dart';
import '../widgets/note_floating_act_bar.dart';
import '../widgets/play_time_row.dart';

class MusicEventAddingScreen extends StatefulWidget {
  final DateTime dateTime;
  final MusicEvent musicEvent;
  MusicEventAddingScreen(
      {Key? key, required this.dateTime, required this.musicEvent})
      : super(key: key);

  @override
  _MusicEventAddingScreenState createState() => _MusicEventAddingScreenState();
}

class _MusicEventAddingScreenState extends State<MusicEventAddingScreen> {
  late String _appBarDate;
  DatabaseHelper helper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    _appBarDate = DateFormat.yMd('pl_PL').format(widget.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MusicProvider>(context, listen: false).setDate(_appBarDate);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
            onPressed: () {
              _showExitQuestion(context);
            },
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
              TargetTimeRow(
                targetTime: widget.musicEvent.targetTime,
              ),
              PlayTimeRow(
                playTime: widget.musicEvent.playTime,
              ),
              //Tutaj bedzie ekualizer
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: 200,
                ),
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).accentColor,
                  ),
                ),
                onPressed: () {
                  var data = Provider.of<MusicProvider>(context, listen: false);
                  helper
                      .insertEvent(
                    MusicEvent(
                      id: data.temporaryMusicEvent.id,
                      playTime: data.temporaryMusicEvent.playTime,
                      targetTime: data.temporaryMusicEvent.targetTime,
                      note: data.temporaryMusicEvent.note,
                    ),
                  )
                      .then((value) {
                    Provider.of<MusicEvents>(context, listen: false).addEvent(
                      MusicEvent(
                        id: data.temporaryMusicEvent.id,
                        playTime: data.temporaryMusicEvent.playTime,
                        targetTime: data.temporaryMusicEvent.targetTime,
                        note: data.temporaryMusicEvent.note,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.save),
                label: Text("Zapisz wynik"),
              ),
            ],
          ),
        ),
        floatingActionButton: NoteFloatingBar(
          initnote: widget.musicEvent.note,
        ),
      ),
    );
  }

  void _showExitQuestion(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          children: [
            Text(
              'Czy napewno chesz wyjśc bez zapisywania danych?',
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    "Wyjdź",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    var data =
                        Provider.of<MusicProvider>(context, listen: false);
                    helper.insertEvent(
                      MusicEvent(
                        id: data.temporaryMusicEvent.id,
                        playTime: data.temporaryMusicEvent.playTime,
                        targetTime: data.temporaryMusicEvent.targetTime,
                        note: data.temporaryMusicEvent.note,
                      ),
                    );
                    Navigator.of(context).pop();
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    "Zapisz",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
