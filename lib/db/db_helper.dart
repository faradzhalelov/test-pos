import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instanse = DatabaseHelper._();
  late String _path;

  static Database? _database;

  Future<Database> get database async => _database ??= await initDB();

  Future<Database> initDB() async {
    _path = join(await getDatabasesPath(), 'cafe_database.db');
    return await openDatabase(_path, version: 1, onCreate: _onCreate);
  }

  Future<void> _createTables(Database db) async =>
      await db.transaction((txn) async {
        await txn.execute('''
          CREATE TABLE cafe_tables (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');
        await txn.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            price REAL NOT NULL,
            category TEXT NOT NULL
          )
        ''');
        await txn.execute('''
          CREATE TABLE orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cafe_table_id INTEGER,
            created_at TEXT NOT NULL,
            status TEXT NOT NULL,
            FOREIGN KEY (cafe_table_id) REFERENCES cafe_tables(id)
          )
        ''');
        await txn.execute('''
          CREATE TABLE order_products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            order_id INTEGER,
            product_id INTEGER,
            quantity INTEGER NOT NULL,
            FOREIGN KEY (order_id) REFERENCES orders(id),
            FOREIGN KEY (product_id) REFERENCES products(id)
          )
        ''');
      });

  Future<void> addData() async {
    if (_database != null) {
      await _database!.transaction((txn) async {
        // for (int i = 1; i <= 10; i++) {
        //   await txn.insert('cafe_tables', {'name': 'Столик №$i'});
        // }
        // await txn.insert('products', {
        //   'name': 'cola',
        //   'category': 'drinks',
        //   'price': 500,
        // });
        // await txn.insert('products', {
        //   'name': 'kozel',
        //   'category': 'drinks',
        //   'price': 1200,
        // });
        // await txn.insert('products', {
        //   'name': 'hamburger',
        //   'category': 'burgers',
        //   'price': 1000,
        // });
        // await txn.insert('products', {
        //   'name': 'doner',
        //   'category': 'doners',
        //   'price': 700,
        // });
        // await txn.insert('products', {
        //   'name': 'greece',
        //   'category': 'salads',
        //   'price': 2000,
        // });
      });
    }
  }

  Future close() async {
    final db = await instanse.database;
    _database = null;
    await db.close();
  }

  Future deleteDB([String? testPath]) async {
    final db = await instanse.database;
    _database = null;
    await db.close();
    await databaseFactory.deleteDatabase(_path);
  }

  Future<void> _onCreate(Database db, int version) async =>
      await _createTables(db);
}
