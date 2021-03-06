import 'package:edu_app/Datalayer/LocalDB.dart';
import 'package:edu_app/Datalayer/paperMarks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edu_app/Datalayer/Database.dart';

class ProgressController {
  Firebase database = Firebase.getdb();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DBProvider dbProvider = new DBProvider();

  Future<List<PaperMarks>> getPaperList() async {
    List<DBMarks> result = await dbProvider.getResults();
    List<PaperMarks> paperlist = [];
    result.forEach((f) => {
          paperlist.add(PaperMarks(f.marks, f.id)),
        });
    // FirebaseUser user = await firebaseAuth.currentUser();
    // List<PaperMarks> paperlist = await database.getPaperMarks(user.uid);

    return paperlist;
  }
}
