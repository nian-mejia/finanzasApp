import 'package:finances/models/user.dart';
import 'package:finances/pages/account_details.dart';
import 'package:finances/pages/add_account.dart';
import 'package:finances/pages/add_goals.dart';
import 'package:finances/pages/add_budget.dart';
import 'package:finances/pages/categories.dart';
import 'package:finances/pages/get_accounts.dart';
import 'package:finances/pages/get_categories_with_radiuos_buttons.dart';
import 'package:finances/pages/info.dart';
import 'package:finances/pages/loading.dart';
import 'package:finances/pages/login_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes  = {
  "addPresupuesto" : (context) => AddPresupuestoPage(),
  "addGoals" : (context) => AddGoalsPage(),
  "addAccount" : (context) => const AddAccountPage(),
  "info" : (context) => InfoPage(userGlobal),
  "login": (context) => const LoginPage(),
  "loading": (context) => LoadingPage(),
  "categories": (context) => const CategoriePage(),
  "accounts": (context) => const AccountPage(),
  "accountsDetails": (context) => const BudgetDetails(),
  "categories_with_radios": (context) => const CategorieWithRadiuosButtonPage(),
};

