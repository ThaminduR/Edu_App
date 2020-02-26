import 'package:edu_app/Datalayer/Database.dart';
import 'package:edu_app/Datalayer/LocalDB.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Paper {
  DBProvider dbProvider = new DBProvider();

  String id;
  List<Question> qs;
  int htime;
  int mtime;
  String url;

  Paper({
    this.id,
    this.qs,
    this.htime,
    this.mtime,
  });

  factory Paper.fromJson(Map<String, dynamic> json) {
    var list = json['qs'] as List;
    List<Question> qsList = list.map((i) => Question.fromJson(i)).toList();
    return Paper(
      id: json["id"],
      qs: qsList,
      htime: json["htime"],
      mtime: json["mtime"],
    );
  }
  void setUrl(url) {
    this.url = url;
  }

  void saveAnswers(answers, correct) async {
    Firebase db = Firebase.getdb();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('number');
    print(user);
    if (await db.firstTime(user, this.id)) {
      db.uploadAnswers(this, answers, correct);
    }
  }

  void updateScore(correct) async {
    Firebase db = Firebase.getdb();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('number');
    if (await db.firstTime(user, this.id)) {
      db.updateLeaderboard(user, correct);
    }
  }

  Future<bool> checkFirstTime(user) async {
    Firebase db = Firebase.getdb();
    return await db.firstTime(user, this.id);
  }

  int countAnswers(answers) {
    int correct = 0;
    answers.forEach((index, value) {
      if (this.qs[index].as[qs[index].a - 1].t == value) correct++;
    });
    return correct;
  }

  void setId(String id) {
    this.id = id;
  }
}

class Question {
  int n;
  Content q;
  List<Answer> as;
  int a;

  Question({
    this.n,
    this.q,
    this.as,
    this.a,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    var asFromJson = json['as'] as List;
    List<Answer> asList = asFromJson.map((i) => Answer.fromJson(i)).toList();
    return Question(
      n: json["n"],
      q: Content.fromJson(json["q"]),
      as: asList,
      a: json["a"],
    );
  }
}

class Answer {
  int n;
  String t;
  String i;

  Answer({
    this.n,
    this.t,
    this.i,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      n: json["n"],
      t: json["t"],
      i: json["i"],
    );
  }
}

class Content {
  String t;
  String i;

  Content({
    this.i,
    this.t,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      t: json["t"],
      i: json["i"],
    );
  }
}
