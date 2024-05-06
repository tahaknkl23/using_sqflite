import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database? _db;

  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  initializeDb() async {
    String dbpath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDb = await openDatabase(dbpath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

 void createDb(Database db, int version) async {
    await db.execute(
        "Create table products(id integer primary key, name text, description text, unitPrice integer)");
  }
}
