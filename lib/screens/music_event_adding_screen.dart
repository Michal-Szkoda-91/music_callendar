import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import '../screens/settings_screen.dart';
import '../databaseHelper/databaseHelper.dart';
import '../models/music_day_event.dart';
import '../widgets/delete_button.dart';
import '../widgets/save_button.dart';
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
    Wakelock.enable();
    Provider.of<MusicProvider>(context, listen: false).setDate(_appBarDate);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          _showExitQuestion(context);
          return true;
        },
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
          backgroundColor: Theme.of(context).backgroundColor,
          body: SingleChildScrollView(
            child: MediaQuery.of(context).orientation == Orientation.portrait
                // Portrait MODE
                //
                //
                ? Column(
                    children: [
                      _createSaveDeleteButton(),
                      TargetTimeRow(
                        targetTime: widget.musicEvent.targetTime,
                      ),
                      PlayTimeRow(
                        playTime: widget.musicEvent.playTime,
                        generalTime: widget.musicEvent.generalTime,
                      ),
                    ],
                  )
                :
                //Landscape MODE
                //
                //
                Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              padding: EdgeInsets.zero,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: _createSaveDeleteButton()),
                          TargetTimeRow(
                            targetTime: widget.musicEvent.targetTime,
                          )
                        ],
                      ),
                      PlayTimeRow(
                        playTime: widget.musicEvent.playTime,
                        generalTime: widget.musicEvent.generalTime,
                      ),
                    ],
                  ),
          ),
          floatingActionButton: NoteFloatingBar(
            initnote: widget.musicEvent.note,
          ),
        ),
      ),
    );
  }

  Widget _createSaveDeleteButton() {
    return widget.musicEvent.id != ''
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DeleteButton(id: _appBarDate, previousContext: context),
              SaveButton(function: _saveResult),
            ],
          )
        : SaveButton(function: _saveResult);
  }

  void _saveResult() {
    var data = Provider.of<MusicProvider>(context, listen: false);
    helper
        .insertEvent(
      MusicEvent(
        id: data.temporaryMusicEvent.id,
        playTime: data.temporaryMusicEvent.playTime,
        generalTime: data.temporaryMusicEvent.generalTime,
        targetTime: data.temporaryMusicEvent.targetTime,
        note: data.temporaryMusicEvent.note,
      ),
    )
        .then((_) {
      Provider.of<MusicEvents>(context, listen: false).addEvent(
        MusicEvent(
          id: data.temporaryMusicEvent.id,
          playTime: data.temporaryMusicEvent.playTime,
          generalTime: data.temporaryMusicEvent.generalTime,
          targetTime: data.temporaryMusicEvent.targetTime,
          note: data.temporaryMusicEvent.note,
        ),
      );
    });
    Wakelock.disable();
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
                    Wakelock.disable();
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
                    helper
                        .insertEvent(
                      MusicEvent(
                        id: data.temporaryMusicEvent.id,
                        playTime: data.temporaryMusicEvent.playTime,
                        generalTime: data.temporaryMusicEvent.generalTime,
                        targetTime: data.temporaryMusicEvent.targetTime,
                        note: data.temporaryMusicEvent.note,
                      ),
                    )
                        .then((_) {
                      Provider.of<MusicEvents>(context, listen: false).addEvent(
                        MusicEvent(
                          id: data.temporaryMusicEvent.id,
                          playTime: data.temporaryMusicEvent.playTime,
                          generalTime: data.temporaryMusicEvent.generalTime,
                          targetTime: data.temporaryMusicEvent.targetTime,
                          note: data.temporaryMusicEvent.note,
                        ),
                      );
                    });
                    Wakelock.disable();
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

  void _navigateToSettings(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(),
      ),
    );
  }
}
