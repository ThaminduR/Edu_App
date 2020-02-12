import 'package:edu_app/UI/colors.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/Controllers/LoginController.dart';

import '../home.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  final nametextcontroller = TextEditingController();
  final numtextcontroller = TextEditingController();

  void dispose() {
    nametextcontroller.dispose();
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
                        'Insert your details',
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
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: nametextcontroller,
                        decoration: new InputDecoration(
                          labelText: "Name",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) {
                          if (val.length < 3) {
                            return "Cannot be less than 4 !";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(),
                      ),
                    ),
                    SizedBox(
                      height: (size.height) * 0.05,
                    ),
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
                          if (val.length < 9) {
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
                  {
                    LoginController.savelogin(
                        nametextcontroller, numtextcontroller),
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        builder: (context) => new HomePage()))
                  },
              },
              label: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
