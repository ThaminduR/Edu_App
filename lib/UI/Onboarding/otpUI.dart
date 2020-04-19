import 'package:edu_app/UI/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/Controllers/LoginController.dart';

import '../home.dart';

class OTPPage extends StatefulWidget {
  String actualCode;
  OTPPage({
    Key key,
    @required this.actualCode,
  }) : super(key: key);
  OTPPageState createState() => OTPPageState();
}

class OTPPageState extends State<OTPPage> {
  final _formKey = new GlobalKey<FormState>();
  final otptextcontroller = TextEditingController();
  final loginController = LoginController();

  String status = '';

  void dispose() {
    otptextcontroller.dispose();
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
                        'Enter OTP',
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
                  )
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
                      ),
                      child: Text(
                        "Auto retrieval failed. Enter the 6 digit OTP you received.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.height * 0.02,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: (size.height) * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: otptextcontroller,
                        decoration: new InputDecoration(
                          labelText: "OTP",
                          //fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) {
                          if (val.length < 6) {
                            return "Invalid length";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        style: new TextStyle(),
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
                  {signInWithPhoneNumber(otptextcontroller.text.toString())},
              },
              label: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }

  void signInWithPhoneNumber(String smsCode) async {
    print(smsCode);
    print("verification id in otp page");
    print(widget.actualCode);
    AuthCredential phoneAuthCredential = await PhoneAuthProvider.getCredential(
        verificationId: widget.actualCode, smsCode: smsCode);
    FirebaseAuth.instance
        .signInWithCredential(phoneAuthCredential)
        .then((AuthResult value) {
      if (value.user != null) {
        print(value.user);
        setState(() {
          status = 'Authentication successful !';
        });
        print('Authentication successful');
        loginController.selectlogin(context);
      } else {
        setState(() {
          status = 'Invalid code/invalid authentication !';
        });
        print('Invalid code/invalid authentication');
      }
    }).catchError((error) {
      setState(() {
        status = 'Something has gone wrong, please try later !';
      });
      print('Something has gone wrong, please try later');
    });
  }
}
