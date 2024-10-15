import 'package:sqflite/sqflite.dart';

import '../../screen/home/model/database_model.dart';

class DatabaseHelper
{
  static DatabaseHelper helper = DatabaseHelper._();
  DatabaseHelper._();
  Database? database;

  Future<Database?> checkDb()
  async {
    if(database == null)
      {
        database = await createDb();
      }
    return database!;
  }

  Future<Database> createDb() async {
    String folder = await getDatabasesPath();
    String path = "$folder/demo.db";
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE contact (cid INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,mobile INTEGER)";

        db.execute(query);
        // database!.execute(query);
      },
    );
  }

  Future<void> insertDb(DatabaseModel model) async {
    database = await checkDb();
    database!.insert('contact', {'name': model.name,'mobile': model.mobile});
    // database!.execute(query);
  }

  Future<List<DatabaseModel>> getData()
  async {
    database = await checkDb();
    String query = "SELECT * FROM contact";
  List<Map> l1 =await database!.rawQuery(query);
  List<DatabaseModel> dbData = l1.map((e) => DatabaseModel.mapToModel(e),).toList();
  print("================  ${dbData.length}");
  return dbData;

  }

  void deleteDb(int id)
  {
    database!.delete("contact",where: "cid=?",whereArgs: [id]);
  }
}