import 'dart:convert';

import 'package:edu_app/Datalayer/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaperMarks {
  String paperid;
  int marks;

  PaperMarks(
    this.marks,
    this.paperid,
  );
}

class DBMarks {
  String id;
  int marks;
  List<GivenAnswer> ans;
  int upload;

  DBMarks({
    this.id,
    this.ans,
    this.marks,
    this.upload,
  });

  factory DBMarks.fromJson(Map<String, dynamic> json) {
    // List asFromJson = jsonDecode(json['ans']);
    // List<GivenAnswer> ansList =
    //     asFromJson.map((i) => GivenAnswer.fromJson(i)).toList();
    return DBMarks(
      id: json["paperid"],
      ans: null,
      marks: json["marks"],
      upload: json["upload"],
    );
  }

  Map<String, dynamic> toJson() => {
        "paperid": id,
        "ans": null,
        //jsonEncode(ans),
        "marks": marks,
        "upload": upload,
      };

  Future<void> saveAnswers() async {
    Firebase db = Firebase.getdb();
    Map<int, dynamic> answers = {};
    ans.forEach((answer) => {answers[answer.qId] = answer.ans});
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseuser = await firebaseAuth.currentUser();
    var user = firebaseuser.uid;
    db.uploadAnswers(user, this, answers, this.marks);
  }

  Future<void> updateScore() async {
    Firebase db = Firebase.getdb();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseuser = await firebaseAuth.currentUser();
    String user = firebaseuser.phoneNumber;
    String uid = firebaseuser.uid;
    bool firsttime = await db.firstTime(uid, this.id);
    if (firsttime) {
      db.updateLeaderboard(user, this.marks);
    }
  }

  void setUpload(up) {
    this.upload = up;
  }
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
