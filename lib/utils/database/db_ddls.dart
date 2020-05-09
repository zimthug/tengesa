import 'package:sqflite/sqflite.dart';

class DbDdls {
  createTables(Database db) async {
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
      total_vat DECIMAL(15,2)""");

    await db.execute("""CREATE TABLE sale_items ( 
      sale_id INTEGER NOT NULL PRIMARY KEY,
      sale_id INTEGER NOT NULL,
      product_id INTEGER NOT NULL,
      quantity DECIMAL(15, 4),
      unit_price DECIMAL(15, 2),
      currency_id INTEGER,
      total_price DECIMAL(15, 2)""");
  }
}
