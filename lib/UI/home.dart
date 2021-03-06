import 'package:edu_app/UI/Paper%20UI/newPaperView.dart';
import 'package:edu_app/UI/settings.dart';
import 'package:edu_app/UI/colors.dart';
import 'package:edu_app/UI/leaderboard.dart';
import 'package:edu_app/UI/Paper UI/paperListView.dart';
import 'package:edu_app/UI/progress.dart';
import 'package:edu_app/UI/lessons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Uncomment text fields to display Sinhala text
//Uncomment decoration image to display children

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String username = 'User';

  @override
  void initState() {
    super.initState();
    // username = await getUsername();

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //get current device screen size
    double rowSpace = size.height * 0.02;
    double colSpace = size.width * 0.06;
    Color tileColor = AppColor.colors[6].color;
    // Colors.teal[800];
    //
    return Scaffold(
        appBar: AppBar(
          title: Text('Grade 5'),
          // centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
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
            image: DecorationImage(
                alignment: Alignment.bottomCenter,
                image: AssetImage(
                    'assets/images/boygirl.png'), //image at the bottom of home page
                fit: BoxFit.fitWidth),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(
              size.width * 0.02,
              size.height * 0.02,
              size.width * 0.02,
              size.height * 0.04,
            ),
            child: Column(
              children: <Widget>[
                // Text(
                //   "Welcome " + username,
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: size.height * 0.025,
                //       shadows: [
                //         Shadow(
                //             // bottomLeft
                //             offset: Offset(-.5, -.5),
                //             color: Colors.teal[900]),
                //         Shadow(
                //             // bottomRight
                //             offset: Offset(.5, -.5),
                //             color: Colors.teal[900]),
                //         Shadow(
                //             // topRight
                //             offset: Offset(.5, .5),
                //             color: Colors.teal[900]),
                //         Shadow(
                //             // topLeft
                //             offset: Offset(-.5, .5),
                //             color: Colors.teal[900]),
                //       ]),
                // ),
                SizedBox(
                  height: rowSpace * 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: size.width * 0.35,
                      width: size.width * 0.35,
                      child: Card(
                        color: tileColor,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(PaperPageRoute());
                          },
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Icon(
                                Icons.book,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              //Uncomment to display sinhala words
                              // Text(
                              //   'ප්‍රශ්න පත්‍ර',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     fontSize: size.height * 0.018,
                              //     color: Colors.white,
                              //   ),
                              // ),
                              Text(
                                'My Papers',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: colSpace,
                    ),
                    Container(
                      height: size.width * 0.35,
                      width: size.width * 0.35,
                      child: Card(
                        color: tileColor,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(NewPaperPageRoute());
                          },
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Icon(
                                Icons.library_books,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                'New Papers',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: rowSpace,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: size.width * 0.35,
                      width: size.width * 0.35,
                      child: Card(
                        color: tileColor,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(ProgressPageRoute());
                          },
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Icon(
                                Icons.show_chart,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              //Uncomment to display sinhala words
                              // Text(
                              //   'පාඩම්',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     fontSize: size.height * 0.018,
                              //     color: Colors.white,
                              //   ),
                              // ),
                              Text(
                                'Progress',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: colSpace,
                    ),
                    Container(
                      height: size.width * 0.35,
                      width: size.width * 0.35,
                      child: Card(
                        color: tileColor,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(LeaderboardPageRoute());
                          },
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Icon(
                                Icons.insert_chart,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              //Uncomment to display sinhala words
                              // Text(
                              //   'ප්‍රමුඛ පුවරුව',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     fontSize: size.height * 0.018,
                              //     color: Colors.white,
                              //   ),
                              // ),
                              Text(
                                'Leaderboard',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: rowSpace,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: size.width * 0.35,
                      width: size.width * 0.35,
                      child: Card(
                        color: tileColor,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(LessonsPageRoute());
                          },
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Icon(
                                Icons.collections_bookmark,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              //Uncomment to display sinhala words
                              // Text(
                              //   'සැකසුම්',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     fontSize: size.height * 0.018,
                              //     color: Colors.white,
                              //   ),
                              // ),
                              Text(
                                'Lessons',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: colSpace,
                    ),
                    Container(
                      height: size.width * 0.35,
                      width: size.width * 0.35,
                      child: Card(
                        color: tileColor,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(SettingsPageRoute());
                          },
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Icon(
                                Icons.supervised_user_circle,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              //Uncomment to display sinhala words
                              // Text(
                              //   'අපි ගැන',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //     fontSize: size.height * 0.018,
                              //     color: Colors.white,
                              //   ),
                              // ),
                              Text(
                                'Settings',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _username = prefs.getString('username');
    print(_username);
    return _username;
  }
}
