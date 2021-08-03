import 'package:flutter/material.dart';
import 'package:music_callendar/models/music_day_event.dart';

class MusicProvider with ChangeNotifier {
  MusicEvent _temporaryEvent = MusicEvent(
    id: '',
    playTime: 0,
    targetTime: 1200,
    note: '',
  );

  MusicEvent get temporaryMusicEvent {
    return _temporaryEvent;
  }

  void setPlayTime(int time) {
    _temporaryEvent.playTime = time;
  }

  void setTargetTime(int time) {
    _temporaryEvent.targetTime = time;
  }

  void setDate(String id) {
    _temporaryEvent.id = id;
  }

  void setNote(String note) {
    _temporaryEvent.note = note;
  }
}
