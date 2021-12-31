

import 'package:finances/provider/database.dart';
import 'package:sqflite/sqflite.dart';

class Account{
  int id;
  String name;
  double value;
  int visible;

  Account._(this.id, this.name, this.value, this.visible); 

  factory Account(String name, double value, int visible){
    return Account._(0, name, value, visible);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "name" : name,
      "value": value,
      "visible": visible
    };
    return map;
  } 
}

Account accountfromJSon(Map<String, Object?> json){
    int id = json["id"] as int;
    String name = json["name"] as String;
    double value = double.parse(json["value"] as String);
    int visible = json["visible"] as int;
    return Account._(id, name, value, visible);
  }

Future<List<Account>> getAccounts() async{
  List<Account> responseAccounts = [];
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> accounts =  await db.query("accounts", where: "visible != 2");
  for (var element in accounts) {
    responseAccounts.add(accountfromJSon(element));
  }
  return responseAccounts;
}

Future<List<Account>> getAllAccounts() async{
  List<Account> responseAccounts = [];
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> accounts =  await db.query("accounts");
  for (var element in accounts) {
    responseAccounts.add(accountfromJSon(element));
  }
  return responseAccounts;
}

Future<double> getTotal() async{
  double total = 0;
  List<Account> responseAccounts = [];
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> accounts =  await db.query("accounts", where: "visible = 1");
  for (var element in accounts) {
    responseAccounts.add(accountfromJSon(element));
  }
  for (var element in responseAccounts){
    total += element.value;
  }
  return total;
}