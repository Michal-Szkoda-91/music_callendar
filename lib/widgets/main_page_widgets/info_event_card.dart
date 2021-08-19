import 'package:flutter/material.dart';

import '../../screens/music_event_adding_screen.dart';
import '../../models/music_day_event.dart';

class InfoEventCard extends StatelessWidget {
  final DateTime dateTime;
  final MusicEvent musicEvent;

  const InfoEventCard({
    Key? key,
    required this.musicEvent,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var targetPlayTime = Duration(seconds: musicEvent.targetTime);
    var playTime = Duration(seconds: musicEvent.playTime);
    return GestureDetector(
      onTap: () {
        _navigatorToAddingScreen(context);
      },
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height *
                    (MediaQuery.of(context).orientation == Orientation.portrait
                        ? 0.05
                        : 0.1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 1],
                    colors: [
                      chooseColor(musicEvent.targetTime, musicEvent.playTime),
                      Theme.of(context).backgroundColor,
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  musicEvent.id,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                'Czas gry: ',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                "${playTime.toString().split(".")[0]} / ${targetPlayTime.toString().split(".")[0]}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ExpansionTile(
                childrenPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                tilePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                title: musicEvent.note == ''
                    ? Text(
                        'brak notatek',
                        style: _noteStyle(),
                      )
                    : musicEvent.note.length < 50
                        ? Text(
                            "${musicEvent.note}",
                            style: _noteStyle(),
                          )
                        : Text(
                            "${musicEvent.note.substring(0, 50)}...",
                            style: _noteStyle(),
                          ),
                children: [
                  Text(
                    "${musicEvent.note}",
                    style: _noteStyle(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _noteStyle() {
    return TextStyle(
      fontSize: 16,
    );
  }

  void _navigatorToAddingScreen(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => MusicEventAddingScreen(
          dateTime: dateTime,
          musicEvent: MusicEvent(
            id: musicEvent.id,
            playTime: musicEvent.playTime,
            generalTime: musicEvent.generalTime,
            targetTime: musicEvent.targetTime,
            note: musicEvent.note,
          ),
        ),
      ),
    );
  }

  Color chooseColor(int target, int play) {
    double proporcion = target / play;

    if (proporcion > 3.3) {
      return Colors.red;
    } else if (proporcion <= 3.3 && proporcion >= 1.2) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}
