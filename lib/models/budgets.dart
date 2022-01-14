// To parse this JSON data, do
//
//     final budget = budgetFromJson(jsonString);

import 'dart:convert';

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
        totalMoney: json["total_money"],
        gastado: json["gastado"],
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
