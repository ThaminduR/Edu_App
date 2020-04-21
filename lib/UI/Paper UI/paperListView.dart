import 'package:edu_app/UI/colors.dart';
import 'package:edu_app/Controllers/paperController.dart';
import 'package:edu_app/UI/Paper UI/quizLoadScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//This page is where all the downloaded papers are listed.

//Added cupertino ios routing animation through creating a routing class
class PaperPageRoute extends CupertinoPageRoute {
  PaperPageRoute() : super(builder: (BuildContext context) => new PaperPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new PaperPage());
  }
}

class PaperPage extends StatelessWidget {
  final PaperController paperController = new PaperController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; //Get current device size
    return Scaffold(
      appBar: AppBar(
        title: Text('My Papers'),
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
        child: FutureBuilder(
          future: paperController
              .getLocalPapers(), //call controller to get data from database
          builder: (context, paperSnap) {
            switch (paperSnap.connectionState) {
              case ConnectionState.none: //if there's no papers in database
                return Text(
                  'No Papers to show',
                  style: TextStyle(color: Colors.teal[800]),
                );
              case ConnectionState.active:
              case ConnectionState.waiting: //show while papers are loading
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    size.width * 0.35,
                    size.height * 0.425,
                    size.width * 0.35,
                    size.height * 0.425,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.white,
                    ),
                    child: Text(
                      'Loading Papers',
                      style: TextStyle(color: Colors.teal[800]),
                    ),
                  ),
                );
              case ConnectionState.done:
                if (paperSnap.hasError)
                  return Text('Error: ${paperSnap.error}');
                if (paperSnap.data.length == 0) {
                  return Center(
                      child: Text(
                    "You don't have any downloaded papers",
                    style: TextStyle(
                        color: Colors.teal[800], fontSize: size.height * 0.02),
                  ));
                } else {
                  return ListView.builder(
                      itemCount: paperSnap.data.length,
                      itemBuilder: (context, position) {
                        return buildPapers(
                          context,
                          size,
                          paperSnap
                              .data[(paperSnap.data.length - 1) - position],
                        ); //builds paper per item in the list from db
                      });
                }
            }
            return null; // unreachable
          },
        ),
      ),
    );
  }
}

Widget buildPapers(context, size, paper) {
  return Padding(
    padding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.02,
        size.width * 0.08, size.height * 0.02),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColor.colors[6].color,
          //color: Color.fromRGBO(36, 209, 99, 0.9),
        ),
        color: Colors.white,
      ),
      child: ExpansionTile(
        title: Text(
          'Question Paper ${paper.number}', // paper id here
          style: TextStyle(
            color: AppColor.colors[6].color,
            fontSize: size.height * 0.02,
          ),
        ),
        children: [
          Text(
            'Time : ${paper.hTime}h ${paper.mTime}m',
            style: TextStyle(
              color: AppColor.colors[6].color,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                0.0, size.height * 0.02, 0.0, size.height * 0.02),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: AppColor.colors[6].color,
              )),
              child: FlatButton(
                color: Colors.white,
                child: Text(
                  'Do the paper',
                  style: TextStyle(
                    color: AppColor.colors[6].color,
                  ),
                ),
                onPressed: () async {
                  return showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        content: Text("Are you ready ?"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, PaperScreen.routeName,
                                  arguments: paper);
                            },
                            child: Text("Yes"),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
