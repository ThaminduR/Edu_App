import 'package:edu_app/Datalayer/Database.dart';

class User {
  String name;
  String number;
  int totalScore;
  DateTime registerDate;

  User(
    this.name,
    this.number,
    //this.registerDate,
    //this.totalScore,
  );

  void setName(name) {
    this.name = name;
  }

  void setScore(score) {
    this.totalScore = score;
  }

  void updateScore(score) {
    this.totalScore += score;
  }

  void setRegisterdate(date) {
    this.registerDate = date;
  }

  void savePaperMarks(paper, answers, marks) {
    Firebase db = Firebase.getdb();
  }
}
