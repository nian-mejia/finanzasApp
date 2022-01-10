import 'package:finances/components/text_fields.dart';
import 'package:finances/models/list/budget_list.dart';
import 'package:finances/models/budgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo presupuesto"),
        actions: [
          TextButton(onPressed: 
            (){
              _saveBudget();
              Navigator.pop(context);
            }, child: const Text("Guardar")),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTextField(nameController, "Nombre del presupuesto"),
            getTextFieldValue(valueController, "Valor"),
            _getCategories()
          ],
        ),
      ),
    );
  }

  _saveBudget(){
    double value = 0;
    if (valueController.text.isNotEmpty){
      value = double.parse(valueController.text);
    }
    final newBudget = Budget(nameController.text, value, 30);
    budgetsList.add(newBudget);
  }

  Widget _getCategories() {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Categoría"),
          ListTile(
              leading: const Icon(Icons.add_box_sharp),
              onTap: () {
                Navigator.pushNamed(context, "categories_with_radios");
              },
            ),
        ],
      ),
    );
  }
}