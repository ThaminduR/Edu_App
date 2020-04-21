import 'package:edu_app/Controllers/LoginController.dart';
import 'package:edu_app/UI/Onboarding/otpUI.dart';
import 'package:edu_app/UI/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NumberPage extends StatefulWidget {
  NumberPageState createState() => NumberPageState();
}

class NumberPageState extends State<NumberPage> {
  final _formKey = new GlobalKey<FormState>();
  final numtextcontroller = TextEditingController();
  LoginController loginController = LoginController();
  String status = "";
  AuthCredential phoneAuthCredential;
  void dispose() {
    // nametextcontroller.dispose();
    numtextcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                new BoxShadow(
                  color: Colors.black38,
                  offset: new Offset(2.0, 2.0),
                )
              ], color: AppColor.colors[1].color),
              child: Column(
                children: <Widget>[
                  Container(
                    width: size.width,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0.0, (size.height) * 0.05, 0.0, 0.0),
                      child: Text(
                        'Enter your phone number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.w200,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black26,
                                offset: Offset(0.5, 0.5),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
              height: (size.height) * 0.1,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB((size.width) * 0.1,
                  (size.height) * 0.1, (size.width) * 0.1, (size.height) * 0.1),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: numtextcontroller,
                        decoration: new InputDecoration(
                          labelText: "Telephone Number",
                          //fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) {
                          if (val.length != 10) {
                            return "Invalid length";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        style: new TextStyle(),
                      ),
                    ),
                    SizedBox(
                      height: (size.height) * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Text(
                        "Ex - 07712312345",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (size.height) * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Text(
                        this.status,
                        style: TextStyle(
                            color: Colors.white, fontSize: size.height * 0.025),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FloatingActionButton.extended(
              backgroundColor: AppColor.colors[1].color,
              onPressed: () => {
                if (_formKey.currentState.validate())
                  {
                    submitPhoneNumber(numtextcontroller, context),
                  },
              },
              label: Text("Send OTP"),
            ),
          ],
        ),
      ),
    );
  }

  //Firebase Auth functions
  Future<void> submitPhoneNumber(numtextcontroller, context) async {
    String phoneNumber = "+94 " + numtextcontroller.text.toString().trim();
    var firebaseAuth = FirebaseAuth.instance;

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      setState(() {
        status = 'Verification Completed !';
      });
      // print('verificationCompleted');
      this.phoneAuthCredential = phoneAuthCredential;

      firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult value) {
        if (value.user != null) {
          setState(() {
            status = 'Authentication successful !';
          });
          // print('Authentication successful');
          loginController.selectlogin(context);
        } else {
          setState(() {
            status = 'Invalid code/invalid authentication !';
          });
          // print('Invalid code/invalid authentication');
        }
      }).catchError((error) {
        setState(() {
          status = 'Something has gone wrong, please try later !';
        });
        // print('Something has gone wrong, please try later');
      });
    };

    final PhoneVerificationFailed verificationFailed = (AuthException error) {
      setState(() {
        status = "Verification failed !";
      });
      // print("Verification failed");
      // print(error);
    };

    final PhoneCodeSent codeSent = (String verificationId, [int code]) {
      setState(() {
        status = "Waiting for OTP auto retrieval ...";
      });
      // print('codeSent');
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      // print('codeAutoRetrievalTimeout');
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => new OTPPage(
                actualCode: verificationId,
              )));
    };

    firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(milliseconds: 3000),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
}
