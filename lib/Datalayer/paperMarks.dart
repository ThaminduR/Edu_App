import 'dart:convert';

import 'package:edu_app/Datalayer/paper.dart';

class PaperMarks {
  String paperid;
  int marks;

  PaperMarks(
    this.marks,
    this.paperid,
  );
}

class DBMarks {
  String paperid;
  int marks;
  List<GivenAnswer> ans;
  int upload;

  DBMarks({
    this.paperid,
    this.ans,
    this.marks,
    this.upload,
  });

  factory DBMarks.fromJson(Map<String, dynamic> json) {
    var asFromJson = json['ans'] as List;
    List<GivenAnswer> ansList =
        asFromJson.map((i) => GivenAnswer.fromJson(i)).toList();
    return DBMarks(
      paperid: json["paperid"],
      ans: ansList,
      marks: json["marks"],
      upload: json["upload"],
    );
  }

  Map<String, dynamic> toJson() => {
        "paperid": paperid,
        "ans": jsonEncode(ans),
        "marks": marks,
        "upload": upload,
      };
}

class GivenAnswer {
  int qId;
  String ans;

  GivenAnswer({
    this.qId,
    this.ans,
  });

  factory GivenAnswer.fromJson(Map<String, dynamic> json) {
    return GivenAnswer(
      qId: json["qId"],
      ans: json["ans"],
    );
  }

  Map<String, dynamic> toJson() => {
        "qId": qId,
        "ans": ans,
      };
}
