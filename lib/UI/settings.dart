import 'package:edu_app/Controllers/LoginController.dart';
import 'package:edu_app/UI/colors.dart';
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

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final LoginController loginController = LoginController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.4, 0.9],
            colors: [
              Colors.cyanAccent[700],
              Colors.cyanAccent[400],
              Colors.cyanAccent,
            ],
          ),
        ),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.1),
              RaisedButton(
                color: Colors.teal[900],
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => {
                  loginController.logout(context),
                },
              ),
              SizedBox(height: size.height * 0.1),
              Center(
                child: Text(
                  "We are TechLabs",
                  style: TextStyle(
                    color: Colors.teal[800],
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
