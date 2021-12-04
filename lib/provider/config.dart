import 'package:finances/models/user.dart';
import 'package:finances/pages/info.dart';
import 'package:finances/pages/login_page.dart';
import 'package:flutter/material.dart';

Future<Widget> getConfigInicialized() async{
  await getUser();
  User user = await getUser();
    if (user.email == ""){
      return const LoginPage();
    }
  return InfoPage(user); 
}