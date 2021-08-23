import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../databaseHelper/databaseHelper.dart';
import '../../models/music_day_event.dart';
import '../../models/music_day_provider.dart';

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
          Theme.of(context).errorColor,
        ),
      ),
      onPressed: () {
        _deleteEvent(widget.previousContext);
        // Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.delete,
        color: Theme.of(context).textTheme.headline1!.color,
      ),
      label: Text(
        tr("DeleteEvent"),
        style: TextStyle(
          color: Theme.of(context).textTheme.headline1!.color,
        ),
      ),
    );
  }

  void _deleteEvent(BuildContext previousContext) {
    showDialog(
        context: previousContext,
        builder: (ctx) {
          return SimpleDialog(
            backgroundColor: Theme.of(context).cardColor,
            children: [
              Text(
                tr("DeleteQuestion"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                      tr("Delete"),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text(
                      tr("Cancel"),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color,
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
