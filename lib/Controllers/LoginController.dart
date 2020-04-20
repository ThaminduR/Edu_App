import 'package:edu_app/UI/Onboarding/nameUI.dart';
import 'package:edu_app/UI/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/Datalayer/Database.dart';

class LoginController {
  Firebase _database = Firebase.getdb();

  Future<void> savelogin(name) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = await firebaseAuth.currentUser();
    String uid = user.uid;
    String number = user.phoneNumber;

    _database.addUser(uid, name, number);
  }

  Future<void> selectlogin(context) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseuser = await firebaseAuth.currentUser();
    String uid = firebaseuser.uid;
    Firebase db = Firebase.getdb();
    bool isnew = await db.checknewUser(uid);
    if (isnew) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new NamePage()));
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new HomePage()));
    }
  }

  Future<bool> isLogged() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseuser = await firebaseAuth.currentUser();
    if (firebaseuser != null) {
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.signOut();
  }
}
