import 'package:edu_app/UI/colors.dart';
import 'package:edu_app/UI/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'onboardingScreens.dart';

class OnBoardingPageState extends State<OnBoardingPage> {
  final List<Widget> introWidgetsList = <Widget>[
    Page1(),
    Page2(),
  ];
  final controller = new PageController();
  int currentPageValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildScreens(),
    );
  }

  Widget buildScreens() {
    return Container(
      child: Stack(
        children: [
          PageView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: introWidgetsList.length,
            onPageChanged: (int page) {
              getChangedPageAndMoveBar(page);
            },
            controller: controller,
            itemBuilder: (context, index) {
              return introWidgetsList[index];
            },
          ),
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 35),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < introWidgetsList.length; i++)
                        if (i == currentPageValue) ...[circleBar(true)] else
                          circleBar(false),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible:
                currentPageValue == introWidgetsList.length - 1 ? true : false,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 30.0),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        builder: (context) => new Splash()));
                  },
                  backgroundColor: AppColor.colors[6].color,
                  label: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.teal[900] : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new OnBoardingPageState();
  }
}
