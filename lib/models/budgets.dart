// To parse this JSON data, do
//
//     final budget = budgetFromJson(jsonString);

import 'dart:convert';

Budget budgetFromJson(String str) => Budget.fromJson(json.decode(str));

String budgetToJson(Budget data) => json.encode(data.toJson());

class Budget {
    Budget({
        required this.name,
        required this.totalMoney,
        required this.saldo,
        required this.gastado,
        required this.day,
    });

    String name;
    double totalMoney;
    double saldo;
    double gastado;
    int day;

    factory Budget.fromJson(Map<String, dynamic> json) => Budget(
        name: json["name"],
        totalMoney: json["total_money"],
        saldo: json["saldo"],
        gastado: json["gastado"],
        day: json["day"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "total_money": totalMoney,
        "saldo": saldo,
        "gastado": gastado,
        "day": day,
    };
}
