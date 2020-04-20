import 'package:edu_app/Controllers/connectivityController.dart';
import 'package:edu_app/UI/colors.dart';
import 'package:edu_app/Controllers/paperController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

//This page is where all the new papers are listed.

//Added cupertino ios routing animation through creating a routing class
class NewPaperPageRoute extends CupertinoPageRoute {
  NewPaperPageRoute()
      : super(builder: (BuildContext context) => new NewPaperPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new NewPaperPage());
  }
}

class NewPaperPage extends StatefulWidget {
  NewPaperPageState createState() => NewPaperPageState();
}

class NewPaperPageState extends State<NewPaperPage> {
  bool isConnected;
  final ConnectivityController connectivityController =
      ConnectivityController();
  final PaperController paperController = new PaperController();
  @override
  Widget build(BuildContext context) {
    checkCon();
    var size = MediaQuery.of(context).size; //Get current device size
    return Scaffold(
      appBar: AppBar(
        title: Text('Papers'),
      ),
      body: Container(
        decoration: BoxDecoration(
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
          future: paperController
              .getNewPapers(), //call controller to get data from database
          builder: (context, paperSnap) {
            switch (paperSnap.connectionState) {
              case ConnectionState.none: //if there's no papers in database
                return Text('No connection !');
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
                if (paperSnap.hasError)
                  return Text(
                      'Connection Error. Please check your internet connection !');
                return ListView.builder(
                  itemCount: paperSnap.data.length,
                  itemBuilder: (context, position) {
                    return buildPapers(
                      context,
                      size,
                      paperSnap.data[(paperSnap.data.length - 1) - position],
                    ); //builds paper per item in the list from db
                  },
                );
            }
            return null; // unreachable
          },
        ),
      ),
    );
  }

  Widget buildPapers(context, size, paper) {
    return Padding(
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.02,
          size.width * 0.05, size.height * 0.02),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.colors[1].color,
            //color: Color.fromRGBO(36, 209, 99, 0.9),
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                Text(
                  'Question Paper ${paper.number}', // paper id here
                  style: TextStyle(
                    color: AppColor.colors[1].color,
                    fontSize: size.height * 0.02,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: AppColor.colors[1].color,
              )),
              child: FlatButton(
                  color: Colors.white,
                  child: Text(
                    'Download the paper',
                    style: TextStyle(
                      color: AppColor.colors[1].color,
                    ),
                  ),
                  onPressed: () async {
                    await checkCon();
                    if (isConnected) {
                      ProgressDialog pr = new ProgressDialog(context);
                      pr = new ProgressDialog(context,
                          type: ProgressDialogType.Normal,
                          isDismissible: false,
                          showLogs: false);
                      pr.style(
                          message: 'Downloading file...',
                          elevation: 10.0,
                          insetAnimCurve: Curves.easeInOut,
                          progressTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400),
                          messageTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w600));
                      pr.show();
                      await paper.downloadFile();
                      pr.update(
                        progress: 50.0,
                        message: "Almost done ...",
                      );
                      await Future.delayed(const Duration(seconds: 2), () {});
                      pr.hide();
                    } else {
                      showAlert(context, size);
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  checkCon() async {
    this.isConnected = await connectivityController.checkConnection();
  }

  void tryAgain() async {
    this.isConnected = await connectivityController.checkConnection();
    if (isConnected) {
      Navigator.of(context).pop();
    }
    setState(() {});
  }

  void showAlert(BuildContext context, size) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Connection Failed !",
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: size.height * 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Please check your internet connection !",
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                  child: Text("Try Again !"),
                  onPressed: () {
                    tryAgain();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
