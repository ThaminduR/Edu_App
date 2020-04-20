import 'package:edu_app/Controllers/connectivityController.dart';
import 'package:edu_app/Controllers/progressController.dart';
import 'package:edu_app/UI/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressPageRoute extends CupertinoPageRoute {
  ProgressPageRoute()
      : super(builder: (BuildContext context) => new ProgressPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new ProgressPage());
  }
}

class ProgressPage extends StatelessWidget {
  final ProgressController progressController = ProgressController();
  final ConnectivityController connectivityController =
      ConnectivityController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Progress",
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage('assets/images/leaderbg.jpg'),
            //   fit: BoxFit.fitHeight,
            // ),
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
          child: FutureBuilder(
              future: progressController.getPaperList(),
              builder: (context, papersnapshot) {
                switch (papersnapshot.connectionState) {
                  case ConnectionState.none: //if there's no papers in database
                    return Text('No Connection !');
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
                        child: Text('Loading Papers'),
                      ),
                    );
                  case ConnectionState.done:
                    if (papersnapshot.hasError)
                      return Text('Error: ${papersnapshot.error}');
                    if (papersnapshot.data.length == 0) {
                      return Center(
                          child: Text(
                        "You haven't done any papers",
                        style: TextStyle(
                            color: Colors.white, fontSize: size.height * 0.02),
                      ));
                    } else {
                      return buildProgress(papersnapshot.data, size);
                    }
                }
                return null;
              }),
        ),
      ),
    );
  }

  Widget buildProgress(paperlist, size) {
    return Container(
      child: ListView.builder(
        itemCount: paperlist.length,
        itemBuilder: (context, position) {
          return buildPaperProgress(size, paperlist[position]);
        },
      ),
    );
  }

  Widget buildPaperProgress(size, paper) {
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.02,
          size.width * 0.08, size.height * 0.02),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.colors[0].color,
        ),
        child: ExpansionTile(
          title: Text(
            "Paper " + paper.paperid,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.height * 0.025,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0.0, size.height * 0.005, 0.0, size.height * 0.02),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: new LinearPercentIndicator(
                  width: 250,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 1000,
                  percent: (paper.marks / 5),
                  center: Text('${(paper.marks / 5) * 100}' + "%"),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
