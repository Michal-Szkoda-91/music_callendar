import 'dart:async';

import 'package:music_callendar/models/music_day_event.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final musicEventTABLE = 'MusicEventTable';

final String columnID = 'id';
final String columnPlayTime = 'playTime';
final String columnTargetTime = 'targetTime';
final String columnNote = 'note';

class DatabaseHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'musicDB.db'), onCreate: (db, version) {
      return db.execute("CREATE TABLE $musicEventTABLE ("
          "$columnID TEXT PRIMARY KEY, "
          "$columnPlayTime INTEGER, "
          "$columnTargetTime INTEGER, "
          "$columnNote TEXT"
          ")");
    }, version: 1);
  }

  Future<void> insertEvent(MusicEvent musicEvent) async {
    final db = await DatabaseHelper.database();
    db.insert(
      musicEventTABLE,
      musicEvent.toDatabaseJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<MusicEvent> getData(String id) async {
    final db = await DatabaseHelper.database();
    Future<List<Map<String, dynamic>>> queryResult =
        db.rawQuery('SELECT * from $musicEventTABLE WHERE $columnID ="$id"');
    MusicEvent event = MusicEvent(id: '', playTime: 0, targetTime: 0, note: '');

    try {
      await queryResult.then(
        (value) {
          event.id = value[0]['id'];
          event.playTime = value[0]['playTime'];
          event.targetTime = value[0]['targetTime'];
          event.note = value[0]['note'];
        },
      );
    } catch (e) {}
    return event;
  }
}
