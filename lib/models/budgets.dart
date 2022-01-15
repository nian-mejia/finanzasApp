// To parse this JSON data, do
//
//     final budget = budgetFromJson(jsonString);

import 'dart:convert';

import 'package:finances/provider/database.dart';
import 'package:sqflite/sqflite.dart';

Budget budgetFromJson(String str) => Budget.fromJson(json.decode(str));

String budgetToJson(Budget data) => json.encode(data.toJson());

class Budget {
    
    Budget(
      {
        required this.name,
        required this.totalMoney,
        required this.gastado,
        required this.day,
    });

    int? id;
    String name;
    double totalMoney;
    double gastado;
    int day;

    factory Budget.fromJson(Map<String, dynamic> json) {
      
      final budget =  Budget(
        name: json["name"],
        totalMoney: double.parse(json["total_money"].toString()),
        gastado: double.parse(json["gastado"].toString()),
        day: json["day"],
    );

      budget.id = json["id"];
      return budget;
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "total_money": totalMoney,
        "gastado": gastado,
        "day": day,
    };
}


Future<List<Budget>> getAllBudget() async{
  List<Budget> responseBudgets = [];
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> budgets =  
    await db.query("budgets");
  for (var element in budgets) {
    responseBudgets.add(Budget.fromJson(element));
  }
  return responseBudgets;
}

Future<Budget> getBudgetByID(int budgetID) async{
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> budgets =  
    await db.query("budgets", where: "id = ?", whereArgs: [budgetID]);
  return Budget.fromJson(budgets.first);
}