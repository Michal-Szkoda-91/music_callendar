import 'dart:async';

import 'package:music_callendar/database/databaseHelper/databaseHelper.dart';
import 'package:music_callendar/models/music_day_event.dart';

class MusicEventDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new MusicEvent records
  Future<int> createMusicEvent(MusicEvent musicEvent) async {
    final db = await dbProvider.database;
    var result = db.insert(musicEventTABLE, musicEvent.toDatabaseJson());
    return result;
  }

  //Get All MusicEvent items
  //Searches if query string was passed
  Future<List<MusicEvent>> getMusicEvents({required String date}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.query(musicEventTABLE,
        where: '$columnDate LIKE ?', whereArgs: ["%$date%"]);

    List<MusicEvent> musicEvents = result.isNotEmpty
        ? result.map((item) => MusicEvent.fromDatabaseJson(item)).toList()
        : [];
    return musicEvents;
  }

  //Update MusicEvent record
  Future<int> updateMusicEvent(MusicEvent musicEvent) async {
    final db = await dbProvider.database;

    var result = await db.update(musicEventTABLE, musicEvent.toDatabaseJson(),
        where: "id = ?", whereArgs: [musicEvent.id]);

    return result;
  }

  //Delete MusicEvent records
  Future<int> deleteMusicEvent(int id) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(musicEventTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllMusicEvents() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      musicEventTABLE,
    );
    return result;
  }
}
