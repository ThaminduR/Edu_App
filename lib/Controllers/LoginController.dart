import 'package:edu_app/Controllers/resultController.dart';
import 'package:edu_app/UI/Onboarding/nameUI.dart';
import 'package:edu_app/UI/home.dart';
import 'package:edu_app/UI/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/Datalayer/Database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  Firebase _database = Firebase.getdb();

  Future<void> savelogin(name) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = await firebaseAuth.currentUser();
    String uid = user.uid;
    String number = user.phoneNumber;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    _database.addUser(uid, name, number);
  }

  Future<void> selectlogin(context) async {
    ResultController resultController = new ResultController();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseuser = await firebaseAuth.currentUser();
    String uid = firebaseuser.uid;
    Firebase db = Firebase.getdb();
    bool isnew = await db.checknewUser(uid);
    FocusScope.of(context).requestFocus(FocusNode());
    if (isnew) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new NamePage()));
    } else {
      await resultController.loginupload(uid);
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

  Future<FirebaseUser> currentuser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseuser = await firebaseAuth.currentUser();
    if (firebaseuser != null) {
      return firebaseuser;
    }
    return null;
  }

  Future<bool> usernamUnique(name) async {
    Firebase db = Firebase.getdb();
    return db.checkUsername(name);
  }

  Future<void> logout(context) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (context) => new Splash(),
    ));
  }
}
