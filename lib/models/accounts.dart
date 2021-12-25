

import 'package:finances/provider/database.dart';
import 'package:sqflite/sqflite.dart';

class Account{
  String name;
  String value;
  int visible;

  Account._(this.name, this.value, this.visible); 

  factory Account(String name, String value, int visible){
    return Account._(name, value, visible);
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
    String name = json["name"] as String;
    String value = json["value"] as String;
    int visible = json["visible"] as int;
    return Account._(name, value, visible);
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

Future<double> getTotal() async{
  double total = 0;
  List<Account> responseAccounts = [];
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> accounts =  await db.query("accounts", where: "visible = 1");
  for (var element in accounts) {
    responseAccounts.add(accountfromJSon(element));
  }
  for (var element in responseAccounts){
    total += double.parse(element.value);
  }
  return total;
}