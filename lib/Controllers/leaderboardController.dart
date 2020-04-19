import 'package:edu_app/Datalayer/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/Datalayer/Database.dart';

class LeaderboardController {
  Firebase database = Firebase.getdb();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<List<LBUser>> getLBUserList() async {
    List<LBUser> userlist = await database.getLBUsers();
    //Unitl cloud function is implemented to rank the leaderboard
    int count = 1;
    userlist.forEach((f) {
      f.setRank(count);
      count += 1;
    });
    return userlist;
  }

  Future<LBUser> getmyScore() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    return await database.getmyScore(user.phoneNumber);
  }
}
