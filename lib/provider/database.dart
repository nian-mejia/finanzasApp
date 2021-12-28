
import 'package:finances/models/category.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:io';
import 'package:path/path.dart';

class DBProvider {

  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if ( _database != null ) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async{

    // Path save db 
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'financeDB.db');
    print(path);

    // create db
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE users (id INTEGER, name TEXT, email TEXT, url TEXT);');

        await db.execute('CREATE TABLE accounts (id INTEGER PRIMARY KEY, name TEXT, value TEXT, icon TEXT, color TEXT, visible INTEGER);');

        await db.execute('CREATE TABLE goals (id INTEGER PRIMARY KEY, title TEXT, end_date TEXT, money_saved INTEGER, money_end INTEGER, cuota TEXT, status INTEGER);');

        await db.execute('CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT, icon INTEGER);');

        await db.insert("categories", Category("Restaurant", 0xf316).toJson());
        await db.insert("categories", Category("Shoping bag", 0xf016f).toJson());
        await db.insert("categories", Category("Shoping cart", 0xee4b).toJson());
        await db.insert("categories", Category("House", 0xf7f5).toJson());
        await db.insert("categories", Category("Transportation", 0xe180).toJson());
        await db.insert("categories", Category("Travel", 0xe299).toJson());
        await db.insert("categories", Category("Comunications", 0xe643).toJson());
        await db.insert("categories", Category("Health", 0xf0f2).toJson());
        await db.insert("categories", Category("Regalos", 0xf2f4).toJson());
        await db.insert("categories", Category("Incomming", 0xeea2).toJson());
        await db.insert("categories", Category("Others", 0xee71).toJson());
      }
    );
  }

}
