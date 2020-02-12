import 'dart:convert';
import 'dart:io';
import 'package:edu_app/Datalayer/LocalDB.dart';
import 'package:edu_app/Datalayer/paper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

PaperShowcase paperFromJson(String str) =>
    PaperShowcase.fromJson(json.decode(str));

String paperToJson(PaperShowcase data) => json.encode(data.toJson());

class PaperShowcase {
  DBProvider dbProvider = new DBProvider();
  String id;
  String url;
  String name;
  int number;
  int hTime;
  int mTime;

  PaperShowcase({
    this.id,
    this.url,
    this.name,
    this.number,
    this.hTime,
    this.mTime,
  });

  factory PaperShowcase.fromJson(Map<String, dynamic> json) => PaperShowcase(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        number: json["number"],
        hTime: json["hTime"],
        mTime: json["mTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "number": number,
        "hTime": hTime,
        "mTime": mTime,
      };
      
  Future<void> downloadFile() async {
    String url = this.url;
    String filename = this.name;
    Dio dio = new Dio();
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      await dio.download(url, "${dir.path}/$filename");
      dbProvider.addDownload(this);
    } catch (e) {
      print(e);
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> loadPaperAsset(paperName) async {
    String path = await _localPath;
    File file1 = new File('$path/$paperName');
    return await file1.readAsString();
  }

  Future loadPaper(paperName) async {
    String jsonString = await loadPaperAsset(paperName);
    final jsonResponse = await json.decode(jsonString);
    Paper paper = new Paper.fromJson(jsonResponse);
    return (paper);
  }

  Future<bool> checkPaper(paperName) async {
    bool paperexists;
    String path = await _localPath;
    File file1 = new File('$path/$paperName');
    if (await file1.exists()) {
      paperexists = true;
    } else {
      paperexists = false;
    }
    return paperexists;
  }
}
