
import 'package:finances/pages/add_account.dart';
import 'package:finances/pages/add_goals.dart';
import 'package:finances/pages/add_badget.dart';
import 'package:finances/pages/info.dart';
import 'package:finances/pages/loading.dart';
import 'package:finances/pages/login_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes  = {
  "addPresupuesto" : (context) => AddPresupuestoPage(),
  "addGoals" : (context) => AddGoalsPage(),
  "addAccount" : (context) => AddAccountPage(),
  "info" : (context) => InfoPage(null),
  "login": (context) => const LoginPage(),
  "loading": (context) => LoadingPage(),
};

