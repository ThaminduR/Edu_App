import 'package:edu_app/Datalayer/LocalDB.dart';
import 'package:edu_app/Datalayer/paperMarks.dart';

class ResultController {
  DBProvider dbProvider = new DBProvider();

  Future<void> upload(DBMarks result) async {
    bool dbHas = await dbProvider.checkResult(result.paperid);
    if (dbHas) {
    } else {
      await dbProvider.addResult(result);
    }
  }
}
