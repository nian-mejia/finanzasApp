
import 'package:finances/pages/add_goals.dart';
import 'package:finances/pages/add_presupuesto.dart';
import 'package:finances/pages/info.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes  = {
  "addPresupuesto" : (context) => AddPresupuestoPage(),
  "addGoals" : (context) => AddGoalsPage(),
  "info" : (context) => InfoPage(),

};