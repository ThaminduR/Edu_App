import 'package:edu_app/Controllers/leaderboardController.dart';
import 'package:edu_app/UI/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaderboardPageRoute extends CupertinoPageRoute {
  LeaderboardPageRoute()
      : super(builder: (BuildContext context) => new LeaderboardPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new LeaderboardPage());
  }
}

class LeaderboardPage extends StatelessWidget {
  final LeaderboardController leaderboardController = LeaderboardController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.4, 0.9],
              colors: [
                Colors.cyan[700],
                Colors.cyan[400],
                Colors.cyan,
              ],
            ),
          ),
          child: buildScreen(context)),
    );
  }

  Widget buildScreen(context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: FutureBuilder(
        future: leaderboardController.getLBUserList(),
        builder: (context, usersnap) {
          switch (usersnap.connectionState) {
            case ConnectionState.none: //if there's no papers in database
              return Text('No internet connection');
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
                  child: Text('Loading Users'),
                ),
              );
            case ConnectionState.done:
              if (usersnap.hasError) return Text('Error: ${usersnap.error}');
              if (usersnap.data.length == 0) {
                return Center(
                    child: Text(
                  "No users to show",
                  style: TextStyle(
                      color: Colors.white, fontSize: size.height * 0.02),
                ));
              } else {
                return Stack(
                  children: [
                    ListView.builder(
                      itemCount: usersnap.data.length,
                      itemBuilder: (context, position) {
                        return buildUser(
                          size,
                          usersnap.data[position],
                        ); //builds paper per item in the list from db
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: buildMe(leaderboardController.getmyScore(), size),
                    ),
                  ],
                );
              }
          }
          return null;
        },
        // padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      ),
    );
  }

  Widget buildUser(size, user) {
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.02,
          size.width * 0.08, size.height * 0.02),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.teal[800],
            //color: Color.fromRGBO(36, 209, 99, 0.9),
          ),
          color: Colors.white,
        ),
        child: ListTile(
          leading: (user.rank != 0)
              ? Text(
                  user.rank.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green[900],
                  ),
                )
              : Icon(Icons.account_circle),
          trailing: Container(
            width: size.width * 0.2,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.whatshot,
                      color: AppColor.colors[6].color, size: 24.0),
                  Text(user.totalScore.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.colors[6].color,
                      )),
                ]),
          ),
          title: Text(
            user.name.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.colors[6].color,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMe(user, size) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.teal[900],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.02,
            size.width * 0.08, size.height * 0.02),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColor.colors[6].color,
            ),
            color: Colors.white,
          ),
          child: ListTile(
            leading: Text(
              user.rank.toString(),
              style: TextStyle(
                fontSize: 20,
                color: Colors.teal[800],
              ),
            ),
            trailing: Container(
              width: size.width * 0.2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.whatshot,
                        color: AppColor.colors[6].color, size: 24.0),
                    Text(user.totalScore.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColor.colors[6].color,
                        )),
                  ]),
            ),
            title: Text(
              user.name.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.colors[6].color,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
