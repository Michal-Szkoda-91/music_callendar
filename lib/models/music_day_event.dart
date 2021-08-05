import 'package:flutter/cupertino.dart';
import 'package:music_callendar/databaseHelper/databaseHelper.dart';

class MusicEvent {
  String id;
  int playTime;
  int targetTime;
  String note;

  MusicEvent({
    required this.id,
    required this.playTime,
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
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetEvents() async {
    final data = await DatabaseHelper.getData();
    _items = data
        .map((item) => MusicEvent(
            id: item['id'],
            playTime: item['playTime'],
            targetTime: item['targetTime'],
            note: item['note']))
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
}
