import 'package:edu_app/Datalayer/Database.dart';
import 'package:edu_app/Datalayer/LocalDB.dart';
import 'package:edu_app/Datalayer/paperShowcase.dart';


class PaperController {
  Firebase _database = Firebase.getdb();
  DBProvider dbProvider = new DBProvider();

  Future<List> getPapers() async {
    return this._database.getPapers();
  }

  Future<List<PaperShowcase>> compareDB() async {
    List<PaperShowcase> firebasePapers = await getPapers();
    List<String> firebaseid = [];
    firebasePapers.forEach((f) {
      firebaseid.add(f.id);
    });
    List<PaperShowcase> localPapers = await dbProvider.getPapers();
    List<String> localid = [];
    localPapers.forEach((f) {
      localid.add(f.id);
    });

    List<String> outputid = [];
    firebaseid.forEach((element) {
      if (!localid.contains(element)) {
        outputid.add(element);
      } else {
      }
    });
    List<PaperShowcase> output = [];
    firebasePapers.forEach((paper) {
      if (outputid.contains(paper.id)) {
        output.add(paper);
      }
    });

    return output;
  }

  void savetoDB() async {
    List<PaperShowcase> papers = await compareDB();
    papers.forEach((paper) {
      dbProvider.add(paper);
    });
  }

  void testPrintLocalPapers() async {
    List<PaperShowcase> papers = await dbProvider.getPapers();
    papers.forEach((paper) {
      print(paper.name);
    });
  }
}
