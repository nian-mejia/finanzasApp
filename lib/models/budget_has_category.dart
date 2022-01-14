// To parse this JSON data, do
//
//     final budgetHasCategory = budgetHasCategoryFromJson(jsonString);

import 'dart:convert';

import 'package:finances/provider/database.dart';
import 'package:sqflite/sqflite.dart';

BudgetHasCategory budgetHasCategoryFromJson(String str) => BudgetHasCategory.fromJson(json.decode(str));

String budgetHasCategoryToJson(BudgetHasCategory data) => json.encode(data.toJson());

class BudgetHasCategory {
    BudgetHasCategory({
        required this.budget,
        required this.categtory,
    });

    int budget;
    int categtory;

    factory BudgetHasCategory.fromJson(Map<String, dynamic> json) => BudgetHasCategory(
        budget: json["budget"] as int,
        categtory: json["category"] as int,
    );

    Map<String, dynamic> toJson() => {
        "budget": budget,
        "categtory": categtory,
    };
}

Future<List<BudgetHasCategory>> getAllBudgetHasCategory(int categoryID) async{
  List<BudgetHasCategory> responseBudgetHasCategory = [];
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> budgetHasCategory =  
    await db.query("budget_has_category", where: "category = $categoryID");
  for (var element in budgetHasCategory) {
    responseBudgetHasCategory.add(BudgetHasCategory.fromJson(element));
  }
  return responseBudgetHasCategory;
}