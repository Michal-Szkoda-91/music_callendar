import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final musicEventTABLE = 'MusicEventTable';

final String columnId = 'id';
final String columnPlayTime = 'playTime';
final String columnDate = 'date';
final String columnNote = 'note';
final String columnCanByOmmited = 'canByOmmited';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  late Database _database;

  Future<Database> get database async {
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MusicEventTable.db");
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDB,
    );
    return database;
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $musicEventTABLE ("
        "$columnId INTEGER PRIMARY KEY, "
        "$columnPlayTime REAL, "
        "$columnDate TEXT"
        "$columnNote TEXT"
        "$columnCanByOmmited INTEGER"
        ")");
  }
}
