import 'package:flutter/cupertino.dart';
import 'package:music_callendar/databaseHelper/databaseHelper.dart';

class MusicEvent {
  String id;
  int playTime;
  int generalTime;
  int targetTime;
  String note;

  MusicEvent({
    required this.id,
    required this.playTime,
    required this.generalTime,
    required this.targetTime,
    required this.note,
  });

  Map<String, dynamic> toDatabaseJson() => {
        'id': this.id,
        'playTime': this.playTime,
        'targetTime': this.targetTime,
        'note': this.note,
      };
}

class MusicEvents with ChangeNotifier {
  List<MusicEvent> _items = [];

  List<MusicEvent> get items {
    return [..._items];
  }

  MusicEvent findById(String id) {
    MusicEvent event = MusicEvent(
        id: '', playTime: 0, targetTime: 0, generalTime: 0, note: '');
    try {
      event = _items.firstWhere((element) => element.id == id);
    } catch (e) {}
    return event;
  }

  Future<void> fetchAndSetEvents() async {
    final data = await DatabaseHelper.getData();
    _items = data
        .map(
          (item) => MusicEvent(
              id: item['id'],
              playTime: item['playTime'],
              generalTime: item['generalTime'],
              targetTime: item['targetTime'],
              note: item['note']),
        )
        .toList();
    notifyListeners();
  }

  void addEvent(MusicEvent event) {
    bool _itemExist = false;
    _items.forEach((element) {
      if (element.id == event.id) {
        int index = _items.indexWhere((element) => element.id == event.id);
        _items[index] = event;
        _itemExist = true;
      }
    });
    if (!_itemExist) {
      _items.add(event);
    }
    notifyListeners();
  }

  void deleteEvent(String id) {
    int index = 0;
    _items.forEach((element) {
      if (element.id == id) {
        index = _items.indexWhere((element) => element.id == id);
      }
    });
    _items.removeAt(index);
    notifyListeners();
  }
}
