import 'package:edu_app/Controllers/LoginController.dart';
import 'package:edu_app/UI/colors.dart';
import 'package:edu_app/UI/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPageRoute extends CupertinoPageRoute {
  SettingsPageRoute()
      : super(builder: (BuildContext context) => new SettingsPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new SettingsPage());
  }
}

class SettingsPage extends StatelessWidget {
  final LoginController loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              AppColor.colors[1].color,
              AppColor.colors[3].color,
              AppColor.colors[3].color,
              AppColor.colors[3].color,
            ],
          ),
        ),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.1),
              RaisedButton(
                child: Text("Logout"),
                onPressed: () => {
                  loginController.logout(),
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (context) => new Splash(),
                  ))
                },
              ),
              SizedBox(height: size.height * 0.1),
              Center(
                child: Text(
                  "We are TechLabs",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.height * 0.03,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
