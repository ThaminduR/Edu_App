import 'dart:async';
import 'package:edu_app/Controllers/LoginController.dart';
import 'package:edu_app/Controllers/connectivityController.dart';
import 'package:edu_app/Controllers/resultController.dart';
import 'package:edu_app/UI/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/UI/Onboarding/onboarding.dart';
import 'package:edu_app/UI/Onboarding/numberUI.dart';
import 'package:edu_app/Controllers/paperController.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SplashState();
}

class SplashState extends State<Splash> {
  bool isConnected = false;
  bool tryAgain = false;
  bool _first = true;
  ConnectivityController connectivityController = ConnectivityController();

  Future<void> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginController loginController = LoginController();
    PaperController paperController = new PaperController();
    ResultController resultController = new ResultController();
    this.isConnected = await connectivityController.checkConnection();
    bool _seen = (prefs.getBool('seen') ?? false);
    bool islogged = await loginController.isLogged();
    if (_seen) {
      if (this.isConnected) {
        paperController.savetoDB();
        if (!islogged) {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new NumberPage()));
        } else {
          await resultController.checkuploaded();
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new HomePage()));
        }
      } else {
        checkInternet();
      }
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OnBoardingPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 1500), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    // this.isConnected = Provider.of<bool>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.2,
            size.width * 0.1, size.height * 0.3),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.4, 0.9],
            colors: [
              Colors.teal[700],
              Colors.teal[400],
              Colors.teal,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/boygirl2.png'),
            Center(
              child: Text(
                'Grade 5',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * 0.06,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              'Loading information ...',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.height * 0.02,
              ),
            ),
            LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal[800]),
            ),
          ],
        ),
      ),
    );
  }

  void checkInternet() async {
    this.isConnected = await connectivityController.checkConnection();
    if (!this.isConnected && _first) {
      _first = false;
      showAlert(context, context.size);
    }
    if (isConnected) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Splash()));
    }
    // if (tryAgain != !this.isConnected) {
    //     WidgetsBinding.instance.addPostFrameCallback((_) {
    //       setState(() => tryAgain = !this.isConnected);
    //     });
    //   } else {
    //   Navigator.pop(context);
    // }
  }

  void showAlert(BuildContext context, size) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Connection Failed !",
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: size.height * 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Please check your internet connection !",
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                  child: Text("Try Again !"),
                  onPressed: () {
                    checkInternet();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
