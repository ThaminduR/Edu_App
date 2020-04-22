import 'dart:async';
import 'dart:io';
import 'package:edu_app/Datalayer/paperMarks.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:edu_app/Datalayer/paperShowcase.dart';

//Db helper class which access sqlite db
class DBProvider {
  static Database _database;

  Future<Database> get db async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  //initializing of the db. Add more tables if needed
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

      await db.execute("CREATE TABLE Result ("
          "paperid INT PRIMARY KEY,"
          "ans TEXT,"
          "marks INT,"
          "upload INT"
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

  Future<void> addResult(DBMarks marks) async {
    var dbClient = await db;
    marks.paperid =
        (await dbClient.insert('Result', marks.toJson())).toString();
  }

  Future<List<DBMarks>> getResults() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('Result', columns: [
      "paperid",
      "ans",
      "marks",
      "upload",
    ]);
    List<DBMarks> results = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        results.add(DBMarks.fromJson(maps[i]));
      }
    }
    return results;
  }

  Future<void> updateResult(DBMarks marks) async {
    var dbClient = await db;
    marks.paperid = dbClient.update('Result', marks.toJson()).toString();
  }

  Future<bool> checkResult(paperid) async {
    var dbClient = await db;
    var result =
        await dbClient.query('Paper', where: "id = ?", whereArgs: [paperid]);
    if (result.isNotEmpty) {
      return true;
    }
    return false;
  }

  //to add paper metadata to local db
  Future<void> add(PaperShowcase paper) async {
    var dbClient = await db;
    paper.id = (await dbClient.insert('Paper', paper.toJson())).toString();
  }

  //to add metadata of downloaded papers to local db
  Future<void> addDownload(PaperShowcase paper) async {
    var dbClient = await db;
    paper.id =
        (await dbClient.insert('downloadedPaper', paper.toJson())).toString();
  }

  //to get a paper by its id from local db
  Future<PaperShowcase> getPaperbyId(int id) async {
    var dbClient = await db;
    var result =
        await dbClient.query('Paper', where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? PaperShowcase.fromJson(result.first) : Null;
  }

  //to get all the papers currently available in the firebase.
  //This infact return all the paper metadata in local db
  //Local db is updated every time the app is opened.
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

  //to get a list of downloaded paper metadata.
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
