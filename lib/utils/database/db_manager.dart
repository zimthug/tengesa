import 'dart:async';
import 'dart:io' as io;

//import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tengesa/model/category.dart';
import 'package:tengesa/model/category_products.dart';
import 'package:tengesa/model/currency.dart';
import 'package:tengesa/model/product.dart';
import 'package:tengesa/model/product_measure.dart';
import 'package:tengesa/model/user.dart';
import 'package:tengesa/utils/database/db_ddls.dart';

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
    //DbDdls dbDdls;
    //dbDdls.createTables(db);
    await db.execute("""CREATE TABLE users (
      user_id INTEGER NOT NULL PRIMARY KEY,
      email TEXT NOT NULL,
      username TEXT NOT NULL,
      password TEXT NOT NULL,
      role TEXT NOT NULL,
      branch_id INTEGER NOT NULL,
      dated DATE)""");

    await db.execute("""CREATE TABLE branches (
      branch_id INTEGER NOT NULL PRIMARY KEY,
      branch_name TEXT NOT NULL)""");

    await db.execute("""CREATE TABLE currencies (
      currency_id INTEGER PRIMARY KEY,
      currency TEXT,
      currency_code TEXT,
      currency_sign TEXT)""");

    await db.execute("""CREATE TABLE product_measures (
      product_measure_id INTEGER PRIMARY KEY,
      product_abbrv TEXT,
      product_measure TEXT)""");

    await db.execute("""CREATE TABLE categories (
        category_id INTEGER PRIMARY KEY,
        branch_id INTEGER,
        category TEXT)""");

    await db.execute("""CREATE TABLE products (
      product_id INTEGER PRIMARY KEY,
      category_id INTEGER,
      product TEXT,
      product_code TEXT,
      product_measure_id INTEGER)""");

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

    await db.execute("""CREATE TABLE sales (
      sale_id INTEGER NOT NULL PRIMARY KEY,
      sale_status INTEGER,
      start_date DATE,
      end_date DATE,
      currency_id INTEGER,
      total_price DECIMAL(15,2),
      total_vat DECIMAL(15,2) )""");

    await db.execute("""CREATE TABLE sale_items ( 
      sale_item_id INTEGER NOT NULL PRIMARY KEY,
      sale_id INTEGER NOT NULL,
      product_id INTEGER NOT NULL,
      quantity DECIMAL(15, 4),
      unit_price DECIMAL(15, 2),
      currency_id INTEGER,
      total_price DECIMAL(15, 2) )""");
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
    sql =
        "SELECT * FROM categories WHERE category IS NOT NULL ORDER BY category";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<Category> list = result.map((item) {
      return Category.fromMap(item);
    }).toList();

    return list;
  }

  Future<List<ProductMeasure>> getUnitMeasureData() async {
    var dbClient = await db;
    String sql;
    sql = "SELECT * FROM product_measures ORDER BY product_measure";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<ProductMeasure> list = result.map((item) {
      return ProductMeasure.fromMap(item);
    }).toList();

    return list;
  }

  Future<List<CategoryProducts>> getCategoryWithProductCount(
      int branchId) async {
    var dbClient = await db;
    String sql;
    sql =
        """select c.category_id, IFNULL(category, 'XX') AS category, (select count(*) from products p 
              where p.category_id = c.category_id) as products from categories c
              where c.branch_id = ?""";

    var result = await dbClient.rawQuery(sql, [branchId]);
    if (result.length == 0) {
      return null;
    }

    List<CategoryProducts> list = result.map((item) {
      return CategoryProducts.fromMap(item);
    }).toList();

    return list;
  }

  Future<List<ProductDetails>> getProductsDetails(productId, categoryId) async {
    var dbClient = await db;
    String sql;
    sql = """select pr.*, ct.category, cast(min_stock as double) as min_stock, 
              cast(max_stock as double) as max_stock, cast(current_stock as double) as current_stock, 
            (select cast(price as double) from product_prices 
              where product_id = pr.product_id 
                and currency_id = 501) as rtgs, 
            (select cast(price as double) from product_prices 
              where product_id = pr.product_id 
                and currency_id = 502) as ecocash,
            (select cast(price as double) from product_prices 
              where product_id = pr.product_id 
                and currency_id = 503) as usd
            from products pr left outer join 
            categories ct on pr.category_id = ct.category_id left outer join
            product_stocks ps on pr.product_id = ps.product_id""";

    /*where pr.product_id = IFNULL(?, pr.product_id)
             and pr.category_id = IFNULL(?, pr.category_id)""";*/

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) {
      return null;
    }

    List<ProductDetails> list = result.map((item) {
      return ProductDetails.fromMap(item);
    }).toList();

    return list;
  }

  Future<List<ProductDetails>> findProductsDetailsByName(String product) async {
    var dbClient = await db;
    String sql;
    sql = """select pr.*, ct.category, cast(min_stock as double) as min_stock, 
              cast(max_stock as double) as max_stock, cast(current_stock as double) as current_stock, 
            (select cast(price as double) from product_prices 
              where product_id = pr.product_id 
                and currency_id = 501) as rtgs, 
            (select cast(price as double) from product_prices 
              where product_id = pr.product_id 
                and currency_id = 502) as ecocash,
            (select cast(price as double) from product_prices 
              where product_id = pr.product_id 
                and currency_id = 503) as usd
            from products pr left outer join 
            categories ct on pr.category_id = ct.category_id left outer join
            product_stocks ps on pr.product_id = ps.product_id 
              where upper(product) like '%'||?||'%' """;

    var result = await dbClient.rawQuery(sql, [product.toUpperCase()]);
	//print(result.toString());
    if (result.length == 0) {
      return null;
    }

    List<ProductDetails> list = result.map((item) {
      return ProductDetails.fromMap(item);
    }).toList();

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

  Future<int> getMaxProductId() async {
    var dbClient = await db;
    String sql;
    sql = "SELECT IFNULL(MAX(product_id), 7000001) FROM products";

    var result = await dbClient.rawQuery(sql);
    return Sqflite.firstIntValue(result);
  }

  Future<void> intializeDatabase() {
    print("Adding currencies");
    Currency currency1 = Currency(501, "Zim RTGS", "RTGS\$", "RTGS\S");
    Currency currency2 = Currency(502, "Ecocash", "RTGS\$", "RTGS\S");
    Currency currency3 = Currency(503, "USD", "USD", "\S");

    saveCurrencyData(currency1);
    saveCurrencyData(currency2);
    saveCurrencyData(currency3);

    print("Adding product_measures");
    ProductMeasure prod1 = ProductMeasure(201, "L", "Litre");
    ProductMeasure prod2 = ProductMeasure(202, "ML", "Millilitre");
    ProductMeasure prod3 = ProductMeasure(203, "KG", "Kilogram");
    ProductMeasure prod4 = ProductMeasure(204, "G", "Milligram");
    ProductMeasure prod5 = ProductMeasure(205, "M", "Metre");
    ProductMeasure prod6 = ProductMeasure(206, "CM", "Centimeter");
    ProductMeasure prod7 = ProductMeasure(207, "U", "Unit");

    saveProductMeasureData(prod1);
    saveProductMeasureData(prod2);
    saveProductMeasureData(prod3);
    saveProductMeasureData(prod4);
    saveProductMeasureData(prod5);
    saveProductMeasureData(prod6);
    saveProductMeasureData(prod7);
  }

  Future<void> intializeTestUser() {
    /* This function is only used for testing */
    print("Adding users");
    User u01 = User(10, "cashier@tengesa.co.zw", "cashier", "123654", "CASHIER",
        10001, " ");
    User u02 =
        User(50, "admin@tengesa.co.zw", "admin", "123654", "ADMIN", 10001, " ");
    saveUserData(u01);
    saveUserData(u02);
  }

  Future<int> saveUserData(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("users", user.toMap());
    return res;
  }

  Future<int> saveCurrencyData(Currency currency) async {
    var dbClient = await db;
    int res = await dbClient.insert("currencies", currency.toMap());
    return res;
  }

  Future<int> saveProductMeasureData(ProductMeasure productMeasure) async {
    var dbClient = await db;
    int res = await dbClient.insert("product_measures", productMeasure.toMap());
    return res;
  }

  Future<int> saveProductData(Product product) async {
    var dbClient = await db;
    int res = await dbClient.insert("products", product.toMap());
    return res;
  }

  Future<int> saveProductPrice(ProductPrice productPrice) async {
    var dbClient = await db;
    if (productPrice.productPriceId == -1) {
      String sql =
          "SELECT IFNULL(MAX(product_price_id), 1007281) FROM product_prices";
      var result = await dbClient.rawQuery(sql);
      productPrice.productPriceId = Sqflite.firstIntValue(result) + 1;
    }

    int res = await dbClient.insert("product_prices", productPrice.toMap());
    return res;
  }

  Future<int> saveProductStock(ProductStock productStock) async {
    var dbClient = await db;
    if (productStock.productStockId == -1) {
      String sql =
          "SELECT IFNULL(MAX(product_stock_id), 3780010) FROM product_stocks";
      var result = await dbClient.rawQuery(sql);
      productStock.productStockId = Sqflite.firstIntValue(result) + 1;
    }

    int res = await dbClient.insert("product_stocks", productStock.toMap());
    return res;
  }

  Future<List<User>> findUserByUsername(String username) async {
    var dbClient = await db;
    String sql;
    sql = "SELECT * FROM users WHERE username = ?";

    var result = await dbClient.rawQuery(sql, [username]);
    if (result.length == 0) {
      return null;
    }

    List<User> list = result.map((item) {
      return User.fromMap(item);
    }).toList();

    return list;
  }

  Future<int> getMaxSaleId() async {
    var dbClient = await db;
    String sql;
    sql = "SELECT IFNULL(MAX(sale_id), 300001) FROM sales";

    var result = await dbClient.rawQuery(sql);
    return Sqflite.firstIntValue(result);
  }

  Future<List<Currency>> getCurrencyData() async {
    var dbClient = await db;
    String sql;
    sql =
        "SELECT * FROM currencies ORDER BY currency";

    var result = await dbClient.rawQuery(sql);
    if (result.length == 0) return null;

    List<Currency> list = result.map((item) {
      return Currency.fromMap(item);
    }).toList();

    return list;
  }

}
