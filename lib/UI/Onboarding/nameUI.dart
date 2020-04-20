import 'package:edu_app/UI/colors.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/Controllers/LoginController.dart';

import '../home.dart';

class NamePage extends StatefulWidget {
  NamePageState createState() => NamePageState();
}

class NamePageState extends State<NamePage> {
  final _formKey = new GlobalKey<FormState>();
  final nametextcontroller = TextEditingController();
  final loginController = LoginController();
  // String status = '';
  bool _first = true;
  bool _isLoggedIn = false;
  bool _isInAsyncCall = false;
  bool _isInvalidAsyncUser = false;

  void dispose() {
    nametextcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _formKey.currentState?.validate();
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
                        'Enter Your Name',
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
                          labelText: "Username",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) {
                          if (!_first) {
                            return validateName(val);
                          } else {
                            _first = false;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
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
                        "Username should be atleast 6 characters long",
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
                    _formKey.currentState.save(),
                    FocusScope.of(context).requestFocus(new FocusNode()),
                    setState(() {
                      _isInAsyncCall = true;
                    }),
                    Future.delayed(Duration(milliseconds: 10), () async {
                      bool isUnique = await loginController
                          .usernamUnique(nametextcontroller.text);
                      setState(() {
                        if (isUnique) {
                          _isInvalidAsyncUser = false;
                          _isLoggedIn = true;
                        } else {
                          _isInvalidAsyncUser = true;
                        }
                      });
                      _isInAsyncCall = false;
                    }),
                    if (_isLoggedIn)
                      {
                        log(),
                      }
                  }
              },
              label: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }

  log() {
    loginController.savelogin(nametextcontroller.text.toString());
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new HomePage()));
  }

  String validateName(String name) {
    if (name.length == 0) {
      return 'Please enter a valid username';
    }
    if (name.length < 6) {
      return 'Invalid length';
    }
    if (_isInvalidAsyncUser) {
      _isInvalidAsyncUser = false;
      return 'Username Already Exists';
    }
    return null;
  }
}
