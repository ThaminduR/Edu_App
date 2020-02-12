import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:edu_app/Datalayer/paperShowcase.dart';

class DBProvider {
  // DBProvider._();
  // static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get db async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Grade5.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Paper ("
          "id TEXT PRIMARY KEY,"
          "url TEXT,"
          "name TEXT,"
          "number INT,"
          "hTime INT,"
          "mTime INT"
          ")");

      await db.execute("CREATE TABLE downloadedPaper ("
          "id TEXT PRIMARY KEY,"
          "url TEXT,"
          "name TEXT,"
          "number INT,"
          "hTime INT,"
          "mTime INT"
          ")");
    });
  }

  Future<void> add(PaperShowcase paper) async {
    var dbClient = await db;
    paper.id = (await dbClient.insert('Paper', paper.toJson())).toString();
  }

  Future<void> addDownload(PaperShowcase paper) async {
    var dbClient = await db;
    paper.id =
        (await dbClient.insert('downloadedPaper', paper.toJson())).toString();
  }

  Future<PaperShowcase> getPaperbyId(int id) async {
    var dbClient = await db;
    var result =
        await dbClient.query('Paper', where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? PaperShowcase.fromJson(result.first) : Null;
  }

  Future<List<PaperShowcase>> getPapers() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('Paper', columns: [
      'id',
      'url',
      'name',
      'number',
      'hTime',
      'mTime',
    ]);
    List<PaperShowcase> papers = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        papers.add(PaperShowcase.fromJson(maps[i]));
      }
    }
    return papers;
  }

  Future<List<PaperShowcase>> getdownPapers() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('downloadedPaper', columns: [
      'id',
      'url',
      'name',
      'number',
      'hTime',
      'mTime',
    ]);
    List<PaperShowcase> papers = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        papers.add(PaperShowcase.fromJson(maps[i]));
      }
    }
    return papers;
  }
}
