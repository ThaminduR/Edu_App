import 'dart:async';
import 'package:edu_app/UI/Onboarding/otpUI.dart';
import 'package:edu_app/UI/Onboarding/numberUI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Not used anywhere

class AuthController {
  var phoneAuthCredential;
  final loginPageKey = GlobalKey<NumberPageState>();

  Future<void> submitPhoneNumber(numtextcontroller, context) async {
    String phoneNumber = "+94 " + numtextcontroller.text.toString().trim();
    print(phoneNumber);

    var firebaseAuth = await FirebaseAuth.instance;

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      loginPageKey.currentState.status = 'Verification Completed !';
      print('verificationCompleted');
      this.phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);

      firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult value) {
        if (value.user != null) {
          print(value.user);
          loginPageKey.currentState.status = 'Authentication successful !';
          print('Authentication successful');
          onAuthenticationSuccessful();
        } else {
          loginPageKey.currentState.status =
              'Invalid code/invalid authentication !';
          print('Invalid code/invalid authentication');
        }
      }).catchError((error) {
        loginPageKey.currentState.status =
            'Something has gone wrong, please try later !';
        print('Something has gone wrong, please try later');
      });
    };

    final PhoneVerificationFailed verificationFailed = (AuthException error) {
      loginPageKey.currentState.status = "Verificiation failed !";
      print("Verificiation failed");
      print(error);
    };

    final PhoneCodeSent codeSent = (String verificationId, [int code]) {
      loginPageKey.currentState.status = "Code Sent !";
      print('codeSent');
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      loginPageKey.currentState.status = 'Code Auto Retrieval Timeout !';
      print('codeAutoRetrievalTimeout');
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OTPPage()));
    };

    firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(milliseconds: 5000),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void onAuthenticationSuccessful() {
    print("Hello ! Welcome");
  }

  void logout() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    user.delete();
    try {
      await FirebaseAuth.instance.signOut();
      print("logged out");
    } catch (e) {
      print(e.toString());
    }
  }
}
