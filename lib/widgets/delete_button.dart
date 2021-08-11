import 'package:flutter/material.dart';
import 'package:music_callendar/databaseHelper/databaseHelper.dart';
import 'package:music_callendar/models/music_day_event.dart';
import 'package:music_callendar/models/music_day_provider.dart';
import 'package:provider/provider.dart';

class DeleteButton extends StatefulWidget {
  final String id;
  final BuildContext previousContext;
  const DeleteButton({
    Key? key,
    required this.id,
    required this.previousContext,
  }) : super(key: key);

  @override
  _DeleteButtonState createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColor,
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.red,
        ),
      ),
      onPressed: () {
        _deleteEvent(widget.previousContext);
        // Navigator.of(context).pop();
      },
      icon: Icon(Icons.delete),
      label: Text("Usuń wydarz."),
    );
  }

  void _deleteEvent(BuildContext previousContext) {
    showDialog(
        context: previousContext,
        builder: (ctx) {
          return SimpleDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            children: [
              Text(
                'Czy napewno chesz usunąć wydarzenie?',
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text(
                      "Anuluj",
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
                      helper.deleteEvent(data.temporaryMusicEvent.id).then(
                        (value) {
                          Provider.of<MusicEvents>(context, listen: false)
                              .deleteEvent(data.temporaryMusicEvent.id);
                        },
                      );
                      Navigator.of(previousContext).pop();
                      Navigator.of(ctx).pop();
                    },
                    child: Text(
                      "Usuń",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
