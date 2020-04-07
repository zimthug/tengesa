import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tengesa/model/category.dart';

class DbManager {
  static final DbManager _instance = new DbManager.internal();
  factory DbManager() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DbManager.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tengesa.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("""CREATE TABLE categories (
        category_id INTEGER PRIMARY KEY,
        branch_id INTEGER,
        category TEXT
        )""");
  }

  Future<int> saveData(Category category) async {
    var dbClient = await db;
    int res = await dbClient.insert("categories", category.toMap());
    return res;
  }

  Future<List<Category>> getCategoryData() async {
    var dbClient = await db;
    String sql;
    sql = "SELECT * FROM categories";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<Category> list = result.map((item) {
      return Category.fromMap(item);
    }).toList();

    print(result);
    return list;
  }
}
