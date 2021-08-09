import 'package:flutter/material.dart';
import 'package:music_callendar/models/music_day_event.dart';

class MusicProvider with ChangeNotifier {
  MusicEvent _temporaryEvent = MusicEvent(
    id: '',
    playTime: 0,
    generalTime: 0,
    targetTime: 1200,
    note: '',
  );
  double _sensitive = 1;

  MusicEvent get temporaryMusicEvent {
    return _temporaryEvent;
  }

  double get sensitive {
    return _sensitive;
  }

  void setSensitive(double sensitive) {
    _sensitive = sensitive;
  }

  void setPlayTime(int time) {
    _temporaryEvent.playTime = time;
  }

  void setTargetTime(int time) {
    _temporaryEvent.targetTime = time;
  }

  void setGeneralTime(int time) {
    _temporaryEvent.generalTime = time;
  }

  void setDate(String id) {
    _temporaryEvent.id = id;
  }

  void setNote(String note) {
    _temporaryEvent.note = note;
  }
}
