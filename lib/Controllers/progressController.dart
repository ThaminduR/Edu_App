import 'package:edu_app/Datalayer/paperMarks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edu_app/Datalayer/Database.dart';

class ProgressController {
  Firebase database = Firebase.getdb();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<List<PaperMarks>> getPaperList() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    List<PaperMarks> paperlist = await database.getPaperMarks(user.uid);
    return paperlist;
  }
}
