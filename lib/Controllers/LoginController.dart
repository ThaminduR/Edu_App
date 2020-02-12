import 'package:shared_preferences/shared_preferences.dart';
import 'package:edu_app/Datalayer/Database.dart';

class LoginController {
  static Future<void> savelogin(nametextcontroller, numtextcontroller) async {
    if (nametextcontroller.text != "" && numtextcontroller.text != "") {
      //var name = nametextcontroller.text;
      var _num = numtextcontroller.text;
      var number = _num.trim();
      if (number.length == 10) {
        number = number.substring(1);
      }
      Firebase db = Firebase.getdb();
      List users = await db.getUsers();
      bool unique = true;
      users.forEach((user) {
        if (user.number == number) {
          unique = false;
        }
      });
      if (unique) {
        //send requrest to ideamart
        //TODO: save to firebase
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', nametextcontroller.text.toString());
      prefs.setString('number', numtextcontroller.text.toString());
    }
  }
}
