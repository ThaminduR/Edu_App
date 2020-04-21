class User {
  String name;
  String number;
  DateTime regDate;

  User(
    this.name,
    this.number,
    this.regDate,
  );
}

class LBUser {
  int totalScore;
  String number;
  String name;
  int rank;

  LBUser(
    this.name,
    this.number,
    this.totalScore,
  );

  setRank(rank) {
    this.rank = rank;
  }
}
