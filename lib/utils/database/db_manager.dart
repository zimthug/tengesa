import 'dart:async';
import 'dart:io' as io;

//import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tengesa/model/category.dart';
import 'package:tengesa/model/category_products.dart';

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
    var tengesaDb = await openDatabase(path,
        version: 1, onCreate: _onCreate /*, onUpgrade: _onUpgrade*/);
    return tengesaDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("""CREATE TABLE currencies (
      currency_id INTEGER PRIMARY KEY,
      currency TEXT,
      currency_code TEXT,
      currency_sign TEXT
      )""");

    await db.execute("""CREATE TABLE product_measures (
      product_measure_id INTEGER PRIMARY KEY,
      product_abbrv TEXT,
      product_measure TEXT)""");

    await db.execute("""CREATE TABLE categories (
        category_id INTEGER PRIMARY KEY,
        branch_id INTEGER,
        category TEXT
        )""");

    await db.execute("""CREATE TABLE products (
      product_id INTEGER PRIMARY KEY,
      category_id INTEGER,
      product TEXT,
      product_code TEXT,
      product_measure_id INTEGER
      )""");

    await db.execute("""CREATE TABLE product_prices (
      product_price_id INTEGER PRIMARY KEY,
      product_id INTEGER,
      currency_id INTEGER,
      price DECIMAL(15,2))""");

    await db.execute("""CREATE TABLE product_stocks (
      product_stock_id INTEGER PRIMARY KEY,
      product_id INTEGER,
      min_stock DECIMAL(15, 4),
      max_stock DECIMAL(15, 4),
      current_stock DECIMAL(15,4))""");

    //insertDefaults();
  }

  FutureOr<void> _onUpgrade(Database db, int oldVer, int newVer) async {
    if (oldVer < newVer) {
      print("Database upgrading ........ ");
      Category undefinedCategory = new Category(10, 1001, 'Undefined');
      await saveCategoryData(undefinedCategory);
    }
  }

  Future<int> saveCategoryData(Category category) async {
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

    //print(result);
    return list;
  }

  Future<List<CategoryProducts>> getCategoryWithProductCount(int branchId) async {
    var dbClient = await db;
    String sql;
    sql = """select c.category_id, IFNULL(category, 'XX') AS category, (select count(*) from products p 
              where p.category_id = c.category_id) as products from categories c
              where c.branch_id = ?""";

    var result = await dbClient.rawQuery(sql, [branchId]);
    if (result.length == 0) {
      print("No data so we are trying someting");
      return null;
    }

    //print("Data available");
    print(result);

    List<CategoryProducts> list = result.map((item) {
      return CategoryProducts.fromMap(item);
    }).toList();

    print("Data available");
    print(list);

    return list;
  }

  Future<int> checkCategoryExists(cat) async {
    var dbClient = await db;
    String sql;
    sql = "SELECT COUNT(*) FROM categories WHERE category = ?";

    var result = await dbClient.rawQuery(sql, [cat]);
    return Sqflite.firstIntValue(result);
  }

  Future<int> getMaxCategoryId() async {
    var dbClient = await db;
    String sql;
    sql = "SELECT IFNULL(MAX(category_id), 0) FROM categories";

    var result = await dbClient.rawQuery(sql);
    return Sqflite.firstIntValue(result);
  }
}
