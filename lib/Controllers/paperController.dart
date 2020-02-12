import 'package:edu_app/Datalayer/Database.dart';
import 'package:edu_app/Datalayer/LocalDB.dart';
import 'package:edu_app/Datalayer/paperShowcase.dart';

class PaperController {
  Firebase _database = Firebase.getdb();
  DBProvider dbProvider = new DBProvider();

  //get paper metadata from firebase
  Future<List> getPapers() async {
    return this._database.getPapers();
  }

  //to compare the papers in local db and firebase
  //papers which are not listed in local db is returned
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
      } else {}
    });
    List<PaperShowcase> output = [];
    firebasePapers.forEach((paper) {
      if (outputid.contains(paper.id)) {
        output.add(paper);
      }
    });

    return output;
  }

  //papers which are not listed in local db is saved to local db
  void savetoDB() async {
    List<PaperShowcase> papers = await compareDB();
    papers.forEach((paper) {
      dbProvider.add(paper);
    });
  }

  //for testing purposes
  void testPrintLocalPapers() async {
    List<PaperShowcase> papers = await dbProvider.getPapers();
    papers.forEach((paper) {
      print(paper.name);
    });
  }

  //to get all the downloaded papers
  Future<List<PaperShowcase>> getLocalPapers() async {
    List<PaperShowcase> papers = await dbProvider.getdownPapers();
    return papers;
  }

  //to get the list of paper which are not downloaded
  Future<List<PaperShowcase>> getNewPapers() async {
    List<PaperShowcase> papers = await dbProvider.getPapers();
    List<String> paperid = [];
    papers.forEach((f) {
      paperid.add(f.id);
    });
    List<PaperShowcase> localPapers = await getLocalPapers();
    List<String> localid = [];
    localPapers.forEach((f) {
      localid.add(f.id);
    });

    List<String> outputid = [];

    paperid.forEach((element) {
      if (!localid.contains(element)) {
        outputid.add(element);
      } else {}
    });

    List<PaperShowcase> output = [];
    papers.forEach((paper) {
      if (outputid.contains(paper.id)) {
        output.add(paper);
      }
    });

    return output;
  }
}
