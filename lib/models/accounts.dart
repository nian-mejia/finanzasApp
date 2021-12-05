

import 'package:finances/provider/database.dart';
import 'package:sqflite/sqflite.dart';

class Account{
  int id;
  String name;
  String value;

  Account._(this.id, this.name, this.value); 

  factory Account(String name, String value){
    return Account._(0, name, value);
  }
  Map<String, dynamic> toJson() {

    Map<String, dynamic> map = {
      "name" : name,
      "value": value,
    };
    return map;
  } 
}

Account accountfromJSon(Map<String, Object?> json){
    int id = json["id"] as int;
    String name = json["name"] as String;
    String value = json["value"] as String;
    return Account._(id, name, value);
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