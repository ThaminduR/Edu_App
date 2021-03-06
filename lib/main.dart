import 'package:edu_app/UI/colors.dart';
import 'package:edu_app/UI/home.dart';
import 'package:edu_app/UI/Onboarding/onboarding.dart';
import 'package:edu_app/UI/Paper UI/quizLoadScreen.dart';
import 'package:edu_app/UI/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // to prevent screen orientation changes. locked to protrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MaterialApp(
    title: "පහේ පන්තිය",
    theme: ThemeData(
        //Colors are defined in AppColor class
        primaryColor: Colors.teal[900],
        // AppColor.colors[0].color,
        primaryColorDark: AppColor.colors[0].color,
        fontFamily: 'Ubuntu'),
    initialRoute: '/',
    routes: {
      '/': (context) =>
          Splash(), //Splash screen determines whether to show onboarding or home
      '/onBoarding': (context) =>
          OnBoardingPage(), //Onboarding is showed only once. Implemented using saved preferences
      '/home': (context) => HomePage(),
      PaperScreen.routeName: (context) => PaperScreen(),
    },
  ));
}
