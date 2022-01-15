
import 'package:finances/provider/database.dart';
import 'package:finances/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    double value = double.parse(json["value"].toString());
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
  final last30Days = getDate(DateTime.now()
    .add(const Duration(days: -30)).toString());

  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> records =  await 
    db.query("records", 
    where: "date >= date(?)", 
    whereArgs: [last30Days], 
    orderBy: "date desc, id desc");
  for (var element in records) {
    responseRecords.add(recordfromJSon(element));
  }
  return responseRecords;
}

Future<List<Record>> getRecordsInRangeDayAndWasExpense(int day, int categoryID) async{
  List<Record> responseRecords = [];
  final currentMonth =  getDate(DateTime(DateTime.now().year, 
    DateTime.now().month, day).toString());

  final rangeMonth = getDate(DateTime(DateTime.now().year, 
    DateTime.now().day >= day ? DateTime.now().month + 1 : 
    DateTime.now().month - 1
    , day).toString());

  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> records =  await 
    db.query("records", 
      where: 'category_id = ? AND type = "gasto" AND date BETWEEN date(?) AND date(?);', 
      whereArgs: DateTime.now().day >= day ?  
        [categoryID, currentMonth, rangeMonth] :
        [categoryID, rangeMonth, currentMonth] ,
        );

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