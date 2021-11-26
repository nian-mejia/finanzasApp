
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
        await db.execute('''
          CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT, icon TEXT, color TEXT);
        ''');

        await db.execute('CREATE TABLE users (id INTEGER, name TEXT, email TEXT, url TEXT);');

        await db.execute('CREATE TABLE accounts (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, icon TEXT, color TEXT);');
      }
    );
  }

}
