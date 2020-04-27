import 'package:edu_app/Datalayer/Database.dart';
import 'package:edu_app/Datalayer/LocalDB.dart';
import 'package:edu_app/Datalayer/paperMarks.dart';

class ResultController {
  DBProvider dbProvider = new DBProvider();
  Firebase _database = Firebase.getdb();

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

  Future<void> loginupload(user) async {
    List<DBMarks> results = await _database.getResult(user);
    results.forEach((result) async => {
          if (await dbProvider.checkResult(result.id))
            {await dbProvider.updateResult(result)}
          else
            {await dbProvider.addResult(result)}
        });
  }
}
