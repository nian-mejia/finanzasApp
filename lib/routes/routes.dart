
import 'package:finances/pages/add_presupuesto.dart';
import 'package:finances/pages/info.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes  = {
  "addPresupuesto" : (context) => AddPresupuestoPage(),
  "info" : (context) => InfoPage(),
};