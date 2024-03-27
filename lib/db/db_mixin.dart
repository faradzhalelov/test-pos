import 'package:pos_order/db/db_helper.dart';
import 'package:sqflite/sqflite.dart';

mixin class DBMixin {
  static late Database _db;

  static Future<void> initDB() async {
    _db = await DatabaseHelper.instanse.database;
  }

  Database get db {
    return _db;
  }
}
