import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonsPageRoute extends CupertinoPageRoute {
  LessonsPageRoute()
      : super(builder: (BuildContext context) => new LessonsPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new LessonsPage());
  }
}

class LessonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Lessons'),
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
          child: Column(
            children: [
              SizedBox(height: size.height * 0.1),
              Center(
                child: Text(
                  "Coming Soon !",
                  style: TextStyle(
                    color: Colors.teal[800],
                    fontSize: size.height * 0.03,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
