
import 'package:finances/provider/database.dart';
import 'package:sqflite/sqflite.dart';

class Record{
    String date;
    String description;
    double value;
    int category;
    int  account;
    String type;

    Record(this.date, this.description, this.value, 
    this.category, this.account, this.type);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "date" : date,
      "value": value,
      "description": description,
      "category_id": category,
      "account_id": account,
      "type": type,
    };
    return map;
  } 
}

Record recordfromJSon(Map<String, Object?> json){
    String date = json["date"] as String;
    String description = json["description"] as String;
    double value = json["value"] as double;
    int category = json["category_id"] as int;
    int account = json["account_id"] as int;
    String type = json["type"] as String;
    return Record(date, description, value, category, account, type);
  }

Future<List<Record>> getRecords() async{
  List<Record> responseRecords = [];
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> records =  await db.query("records");
  for (var element in records) {
    responseRecords.add(recordfromJSon(element));
  }
  return responseRecords;
}

