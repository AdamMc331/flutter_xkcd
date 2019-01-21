import 'dart:io';

import 'package:flutter_xkcd/models/comic.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class XKCDDatabase {
  XKCDDatabase._();

  static final XKCDDatabase db = XKCDDatabase._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "xkcd_database.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE comic ("
          "num INTEGER PRIMARY KEY ON CONFLICT REPLACE,"
          "month TEXT,"
          "link TEXT,"
          "year TEXT,"
          "news TEXT,"
          "safe_title TEXT,"
          "transcript TEXT,"
          "alt TEXT,"
          "img TEXT,"
          "title TEXT,"
          "day TEXT"
          ")");
    });
  }

  newComic(Comic newComic) async {
    final db = await database;
    var res = await db.insert(
      "comic",
      newComic.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  getComic(int number) async {
    final db = await database;
    var res = await db.query("comic", where: "num = ?", whereArgs: [number]);
    return res.isNotEmpty ? Comic.fromJson(res.first) : Null;
  }
}
