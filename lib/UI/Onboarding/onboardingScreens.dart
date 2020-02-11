import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
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
            SizedBox(
              height: size.height * 0.06,
            ),
            Container(
              width: size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black38,
                    offset: new Offset(2.0, 2.0),
                  )
                ],
                color: Colors.blue[400],
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Image(
                    image: AssetImage('assets/images/children.png'),
                    height: size.height * 0.3,
                    width: size.width,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'පහේ පන්තිය',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.height * 0.06,
                        fontWeight: FontWeight.w200,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ]),
                  )
                ],
              ),
              height: (size.height) * 0.5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, (size.height) * 0.1, 0.0, 0.0),
              child: Text(
                'පහේ පන්තිය වෙත ඔබව සාදරයෙන් පිළිගනිමු',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * 0.025,
                  fontWeight: FontWeight.w100,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black26,
                      offset: Offset(0.2, 0.2),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
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
            SizedBox(
              height: size.height * 0.06,
            ),
            Container(
              width: size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black38,
                    offset: new Offset(2.0, 2.0),
                  )
                ],
                color: Colors.blue[400],
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Image(
                    image: AssetImage('assets/images/children.png'),
                    height: size.height * 0.3,
                    width: size.width,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'පහේ පන්තිය',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.height * 0.06,
                        fontWeight: FontWeight.w200,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ]),
                  )
                ],
              ),
              height: (size.height) * 0.5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.015, (size.height) * 0.1, 0.0, 0.0),
              child: Text(
                'අලුත් විදියකට ඉගෙන ගන්න ඔබ සූදානම්ද ? \n පහේ පන්තියෙන් ඔබට සෑම සතියකම අලුත්ම ප්‍රශ්න පත්‍රයක්.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * 0.025,
                  fontWeight: FontWeight.w100,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black26,
                      offset: Offset(0.2, 0.2),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


