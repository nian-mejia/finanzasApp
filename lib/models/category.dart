import 'package:finances/provider/database.dart';
import 'package:sqflite/sqflite.dart';

class Category{
  int id;
  String name;
  int icon;

  Category._(this.id, this.name, this.icon);

  factory Category(String name, int icon){
    return Category._(0, name, icon);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "name" : name,
      "icon": icon,
    };
    return map;
  } 
}

Category categoryfromJSon(Map<String, Object?> json){
    int id = json["id"] as int;
    String name = json["name"] as String;
    int icon = json["icon"] as int;
    return Category._(id, name, icon);
}

Future<List<Category>> getCategories() async{
  List<Category> responseCategories = [];
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> categories =  await db.query("categories");
  for (var element in categories) {
    responseCategories.add(categoryfromJSon(element));
  }
  return responseCategories;
}

Future<Category?> getCategoryByID(int? id) async{
  if (id == null){
    return null;
  }
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> categories =  await db.query("categories", where : "id = $id");
  return categories.isNotEmpty ? categoryfromJSon(categories.first): null;
}