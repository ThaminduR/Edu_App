import 'package:edu_app/Datalayer/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edu_app/Datalayer/Database.dart';

class LeaderboardController {
  Firebase database = Firebase.getdb();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  LBUser currentUser;

  Future<List<LBUser>> getLBUserList() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    List<LBUser> userlist = await database.getLBUsers();

    //Unitl cloud function is implemented to rank the leaderboard
    int count = 1;
    userlist.forEach((f) {
      if (f.number == user.phoneNumber) {
        currentUser = f;
      }
      f.setRank(count);
      count += 1;
    });
    return userlist;
  }

  LBUser getmyScore() {
    return this.currentUser;
  }
}
