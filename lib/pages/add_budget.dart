import 'package:finances/components/icon.dart';
import 'package:finances/components/text_fields.dart';
import 'package:finances/models/category.dart';
import 'package:finances/models/budgets.dart';
import 'package:finances/provider/database.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddPresupuestoPage extends StatefulWidget {
  AddPresupuestoPage({Key? key}) : super(key: key);

  @override
  _AddPresupuestoPageState createState() => _AddPresupuestoPageState();
}

class _AddPresupuestoPageState extends State<AddPresupuestoPage> {

  final nameController = TextEditingController();
  final valueController = TextEditingController();
  List<Category> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo presupuesto"),
        actions: [
          TextButton(onPressed: 
            () =>
              _saveBudget()   
            , child: const Text("Guardar")),
        ],
      ),
      body: ListView(
          children: [
            getTextField(nameController, "Nombre del presupuesto"),
            getTextFieldValue(valueController, "Valor"),
            _getCategories()
          ],
        ),
    );
  }

  _saveBudget() async{
    double value = 0;
    String name = "Presupuesto";

    if (valueController.text.isNotEmpty){
      value = double.tryParse(valueController.text) ?? 0;
    }

    if (nameController.text.isNotEmpty){
      name = nameController.text;
    }

    final newBudget = Budget(
      name: name, day: 30, 
      totalMoney: value, gastado: 0);
    
    int budgetID = await DBProvider.db.database.then((db) => 
      db.insert("budgets", newBudget.toJson()));

    categories.forEach((category) {
      DBProvider.db.database.then((db) => 
      db.insert("budget_has_category", {
        "budget" : budgetID,
        "category": category.id,
      }));
    });

    Navigator.pop(context);
  }

  Widget _getCategories() {
    return  Padding(
            padding:  padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  const Text("Categoría", style: 
                  TextStyle(fontWeight: FontWeight.bold)),
                  categories.isEmpty ? _getIconAdd() :  _drawCategories(categories),
              ]
              )
            );
  }

  Widget _getIconAdd() =>  ListTile(
    trailing : const Icon(Icons.add_box_sharp),
    onTap: () async {
        final categoriesReturn = await Navigator.
                pushNamed(context, "categories_with_radios");
        categoriesReturn != null ? 
          categories = categoriesReturn as List<Category> : null;
        setState(() {});
      },
  );

  Widget _drawCategories(List<Category> categories){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: getCategoriesList(categories),
      );
  }

  List<Widget> getCategoriesList(List<Category> categories) {
    List<Widget> categoriesResponse = [];
    categories.forEach((category) {
      
      final row = Padding(
        padding: const EdgeInsets.all(7.0),
        child: Row(
          children: [
            getIcon(category),
            Text(category.name),
          ]),
      );
      categoriesResponse.add(row);
    });
    categoriesResponse.add(_getIconAdd());
    return categoriesResponse;
  }
}