import 'package:edu_app/Datalayer/classes/Database.dart';

class PaperController {
  Database database = Database.getdb();
  
  Future<List> getPapers() {
    return this.database.getPapers();
  }
}
