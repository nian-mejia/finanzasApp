

import 'package:finances/provider/database.dart';
import 'package:sqflite/sqflite.dart';

class Account{
  int id;
  String name;
  String value;
  String color;

  Account(this.id, this.name, this.value, this.color); 
}

Account accountfromJSon(Map<String, Object?> json){
    int id = json["id"] as int;
    String name = json["name"] as String;
    String value = json["value"] as String;
    String color = json["color"] as String;
    return Account(id, name, value, color);
  }

Future<List<Account>> getAccounts() async{
  List<Account> responseAccounts = [];
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> accounts =  await db.query("accounts");
  for (var element in accounts) {
    responseAccounts.add(accountfromJSon(element));
  }
  return responseAccounts;
}