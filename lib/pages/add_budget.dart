import 'package:finances/components/icon.dart';
import 'package:finances/components/text_fields.dart';
import 'package:finances/models/category.dart';
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
  List<Category> categories = [];

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
      body: Column(
          children: [
            getTextField(nameController, "Nombre del presupuesto"),
            getTextFieldValue(valueController, "Valor"),
            _getCategories()
          ],
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
    return  Padding(
            padding:  padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  const Text("Categoría", style: 
                  TextStyle(fontWeight: FontWeight.bold)),
                  ListTile(
                      trailing: categories.isEmpty ? _getIconAdd() : null,
                      title: categories.isNotEmpty ?  _drawCategories(categories) :
                        const SizedBox(),
                      onTap: () async {
                        final categoriesReturn = await Navigator.
                                pushNamed(context, "categories_with_radios");
                        categoriesReturn != null ? 
                          categories = categoriesReturn as List<Category> : null;
                        setState(() {});
                      },
                    ),
                  ],
              )
            );
  }

  Widget _getIconAdd() => const Icon(Icons.add_box_sharp);

  Widget _drawCategories(List<Category> categories){
    return  Column(
        children: [
          SizedBox(
            height: categories.length < 5 ? (categories.length * 6).h : 35.h,
            child: getCategoriesListView(categories)),
          _getIconAdd(),
        ],
      );
  }

  ListView getCategoriesListView(List<Category> categories) {
    return ListView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, index){
          return Row(
            children: [
              getIcon(categories[index]),
              Text(categories[index].name),
            ]);
        });
  }
}