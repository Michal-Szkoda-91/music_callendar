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

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DatabaseHelper.database();
    return db.query(musicEventTABLE);
  }

  Future<void> deleteEvent(String id) async {
    final db = await DatabaseHelper.database();
    db.delete(musicEventTABLE, where: "id = ?", whereArgs: [id]);
  }
}
