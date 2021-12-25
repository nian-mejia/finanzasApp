
import 'package:finances/provider/database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sqflite/sqflite.dart';

class User {
  String? name;
  String? email;
  String? url;

  User._(this.name, this.url, this.email);

  factory User(GoogleSignInAccount? googleUser){
    if (googleUser != null){
      return User._(googleUser.displayName, googleUser.photoUrl, googleUser.email);
    }
    return User._("", "", "");
  }

  Map<String, dynamic> toJson() {

    Map<String, dynamic> map = {
      "id" : 1,
      "name" : name!,
      "email": email!,
      "url":   url!,
    };
    return map;
  } 

  User fromJSon(Map<String, Object?> json){
    name = json["name"] as String;
    url = json["url"] as String;
    email = json["email"] as String;
    return User._(name, url, email);
  }
}

Future<User> getUser() async{
  User user = User(null);
  Database db = await  DBProvider.db.database;
  List<Map<String, Object?>> users =  await db.query("users", where: "id = 1", whereArgs: [1]);
  return users.isNotEmpty ? user.fromJSon(users.last) : user;
}

