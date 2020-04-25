import 'package:edu_app/Datalayer/LocalDB.dart';
import 'package:edu_app/Datalayer/paperMarks.dart';

class ResultController {
  DBProvider dbProvider = new DBProvider();

  Future<void> upload(DBMarks result) async {
    bool dbHas = await dbProvider.checkResult(result.id);
    if (dbHas) {
      await dbProvider.updateResult(result);
    } else {
      await dbProvider.addResult(result);
    }
  }

  Future<void> checkuploaded() async {
    List<DBMarks> results = await dbProvider.getResults();
    results.forEach((result) async => {
          if (result.upload == 0)
            {
              await result.updateScore(),
              await result.saveAnswers(),
              result.setUpload(1),
              await dbProvider.updateResult(result),
            }
        });
  }
}
