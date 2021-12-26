// ignore_for_file: constant_identifier_names

import 'package:finances/models/cuotas.dart';
import 'package:finances/provider/database.dart';
import 'package:sqflite/sqflite.dart';

class Goal{
  String title;
  String endDate;
  double percent;
  double moneySaved;
  double moneyEnd;
  cuotas? cuota = cuotas.Mensual;
  bool? status;

  Goal._(this.title, this.percent, this.moneySaved,
       this.moneyEnd, this.endDate, this.cuota, this.status);

  factory Goal(String title, String endDate, double moneyEnd,
   double moneySaved, cuotas? cuota, bool status){

    double percent = 0;

    if (moneySaved != 0){
      percent =  moneySaved / moneyEnd;
    }

    cuota ??= cuotas.Mensual;

    return Goal._(title, percent, moneySaved, moneyEnd, endDate, cuota, status);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "title" : title,
      "end_date": endDate,
      "money_saved": moneySaved,
      "money_end": moneyEnd,
      "cuota":  cuota.toString(),
      "status": status! ? 1 : 0,
    };
  return map;
  } 
}

Goal goalfromJSon(Map<String, Object?> json){
    String title = json["title"] as String;
    String endDate = json["end_date"] as String;
    double moneySaved = json["money_saved"] as double;
    double moneyEnd = json["money_end"] as double;
    cuotas cuota = getCuotaByString(json["cuota"] as String);
    bool status = json["status"] as bool;
    return Goal(title, endDate, moneySaved, moneyEnd, cuota, status);
}

Future<List<Goal>> getGoals() async{
  List<Goal> responseAccounts = [];
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> accounts =  await db.query("goals");
  for (var element in accounts) {
    responseAccounts.add(goalfromJSon(element));
  }
  return responseAccounts;
}
