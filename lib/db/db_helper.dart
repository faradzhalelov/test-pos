import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'cafe_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE cafe_tables (
            id INTEGER PRIMARY KEY,
            name TEXT
          )
      ''');
    await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY,
            name TEXT,
            category TEXT,
            price REAL,
            quantity INTEGER,
            image TEXT
          )
      ''');
    await db.execute('''
          CREATE TABLE order_basket (
            id INTEGER PRIMARY KEY,
            cafe_tables_id INTEGER,
            created_at TEXT,
            FOREIGN KEY(cafe_tables_id) REFERENCES cafe_tables(id)
          )
      ''');
    await db.execute('''
          CREATE TABLE products_in_basket (
            id INTEGER PRIMARY KEY,
            order_basket_id INTEGER,
            products_id INTEGER,
            quantity INTEGER,
            FOREIGN KEY(order_basket_id) REFERENCES order_basket(id),
            FOREIGN KEY(products_id) REFERENCES products(id)
          )
      ''');
    await db.execute('''
          CREATE TABLE finished_orders (
            id INTEGER PRIMARY KEY,
            status BOOLEAN,
            created_at TEXT,
            price REAL
          )
      ''');
  }
}
