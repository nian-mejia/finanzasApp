
import 'package:finances/provider/database.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Record{
    String date;
    String description;
    double value;
    int? category;
    int?  accountOrigin;
    int?  accountDest;
    String type;

    Record(this.date, this.description, this.value, 
    this.category, this.accountOrigin, this.accountDest, this.type);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "date" : date,
      "value": value,
      "description": description,
      "category_id": category,
      "account_origin_id": accountOrigin,
      "account_dest_id": accountDest,
      "type": type,
    };
    return map;
  } 
}

Record recordfromJSon(Map<String, Object?> json){
    String date = json["date"] as String;
    String description = json["description"] as String;
    double value = (json["value"] as int).toDouble();
    int? category = (json["category_id"] ==  null) ? null : 
      (json["category_id"] as int);
    int accountOrigin = json["account_origin_id"] as int;
    int? accountDest =  (json["account_dest_id"] ==  null) ? null : 
      (json["account_dest_id"] as int);
    String type = json["type"] as String;
    return Record(date, description, value, category, accountOrigin, accountDest,  type);
  }

Future<List<Record>> getRecords() async{
  List<Record> responseRecords = [];
  final last30Days = DateTime.now().add(const Duration(days: -30));
  String last30DaysFormated = "${last30Days.year}-${last30Days.month}-${last30Days.day}";
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> records =  await db.query("records", where: "date >= date($last30DaysFormated)");
  for (var element in records) {
    responseRecords.add(recordfromJSon(element));
  }
  return responseRecords;
}

Map<String, Color>  colorsRecord = {
  "ingreso": Colors.green,
  "gasto": Colors.red,
  "transfer": Colors.cyan,
};