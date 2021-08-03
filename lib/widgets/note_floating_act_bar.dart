import 'package:flutter/material.dart';
import 'package:music_callendar/models/music_day_provider.dart';
import 'package:provider/provider.dart';

class NoteFloatingBar extends StatefulWidget {
  @override
  _NoteFloatingBarState createState() => _NoteFloatingBarState();
}

class _NoteFloatingBarState extends State<NoteFloatingBar> {
  bool _selected = false;
  String note = "";
  TextEditingController _noteControler = TextEditingController();
  Duration _animationDuration = Duration(milliseconds: 450);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = true;
        });
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).accentColor,
        ),
        width: _selected ? MediaQuery.of(context).size.width - 30 : 60,
        height: _selected ? 300 : 60,
        duration: _animationDuration,
        child: !_selected
            ? AnimatedOpacity(
                duration: _animationDuration,
                opacity: _selected ? 0 : 1,
                child: Icon(
                  Icons.notes,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                      duration: _animationDuration,
                      opacity: _selected ? 1 : 0,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Notatki",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).primaryColor,
                      ),
                      width: _selected
                          ? MediaQuery.of(context).size.width - 50
                          : 0,
                      height: _selected ? 200 : 0,
                      duration: _animationDuration,
                      child: TextField(
                        controller: _noteControler,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        cursorColor: Theme.of(context).accentColor,
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          hintText: 'Wpisz dowolne notatki...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: _animationDuration,
                      opacity: _selected ? 1 : 0,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _selected = false;
                                });
                                Provider.of<MusicProvider>(context,
                                        listen: false)
                                    .setNote(
                                  _noteControler.text,
                                );
                              },
                              icon: Icon(
                                Icons.save,
                                color: Theme.of(context).primaryColor,
                              ),
                              label: Text(
                                "Zapisz",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
