import 'package:edu_app/UI/colors.dart';
import 'package:edu_app/UI/home.dart';
import 'package:edu_app/UI/Onboarding/onboarding.dart';
import 'package:edu_app/UI/Paper UI/quizLoadScreen.dart';
import 'package:edu_app/UI/splash.dart';
import 'package:flutter/material.dart';
// import 'Datalayer/models/connectivity.dart';

void main() {
  // ConnectionStatusSingleton connectionStatus =
  //     ConnectionStatusSingleton.getInstance();
  // connectionStatus.initialize();
  runApp(
    MaterialApp(
      title: "පහේ පන්තිය",
      theme: ThemeData(
          //Colors are defined in AppColor class
          primaryColor: AppColor.colors[0].color,
          primaryColorDark: AppColor.colors[0].color),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(), //Splash screen determines whether to show onboarding or home
        '/onBoarding': (context) => OnBoardingPage(), //Onboarding is showed only once. Implemented using saved preferences
        '/home': (context) => HomePage(),
        PaperScreen.routeName: (context) => PaperScreen(),
      },
    ),
  );
}
