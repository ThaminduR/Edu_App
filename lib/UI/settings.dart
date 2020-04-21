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
        title: Text('About Us'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.blue[800],
              Colors.blue[700],
              Colors.blue[600],
              Colors.blue[400],
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
                  loginController.logout(context),
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
