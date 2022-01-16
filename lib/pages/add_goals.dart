import 'package:finances/components/text_fields.dart';
import 'package:finances/constants/button_style.dart';
import 'package:finances/constants/titles.dart';
import 'package:finances/models/accounts.dart';
import 'package:finances/models/goals.dart';
import 'package:finances/models/cuotas.dart';
import 'package:finances/provider/database.dart';
import 'package:finances/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddGoalsPage extends StatefulWidget {
  AddGoalsPage({Key? key}) : super(key: key);

  @override
  _AddGoalsPageState createState() => _AddGoalsPageState();
}

class _AddGoalsPageState extends State<AddGoalsPage> {

  final nameController = TextEditingController();
  final valueController = TextEditingController();
  final savedController = TextEditingController();
  final dateController =  TextEditingController(
    text: getDateFormated(DateTime.now().toString()));

  final space = const SizedBox(height: 15);
  cuotas defaultCouta = cuotas.Mensual;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo objetivo"),
        actions: [
          TextButton(onPressed: 
            (){
              if (_formKey.currentState!.validate()) {
                final message = _saveGoal();
                if (message.isNotEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(backgroundColor: colorApp,
                    content: Text(message, 
                      style: const TextStyle(color: Colors.white,
                       fontWeight: FontWeight.bold),)),
                  );
                }
              }
            }, child: const Text("Guardar")),
        ],
      ),
      body: Form(
          key: _formKey,
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTextField(nameController,  "Nombre del objetivo"),
            getTextFieldValue(valueController, "Valor"),
            getTextFieldValue(savedController, "Ya ahorrado"),
            getDataPicker(dateController, "Fecha deseada", context),
            _getCuotas(),
          ],
        ),
      ),
    );
  }

  Widget _getCuotas(){

    List<DropdownMenuItem<String>> items = [];

    cuotas.values.forEach((item){
      items.add(DropdownMenuItem(
        value: item.toString(),
        child: Text(item.name)));
    });

    return Padding(
      padding: padding,
      child: SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Periodos", style: titleStyle,),
            DropdownButton(
              value: defaultCouta.toString(),
              items: items, 
              onChanged: (String? item){
                setState(() {
                  defaultCouta = getCuotaByString(item);
                });
              }
              ),
          ],
        ),
      ),
    );
  }

  String _saveGoal(){
    double totalValue = 0;
    double savedMoney = 0;
    String name = "Goal";

    if (valueController.text.isNotEmpty){
      totalValue = double.parse(valueController.text);
    }
    if (savedController.text.isNotEmpty){
      savedMoney = double.parse(savedController.text);
    }

    if (nameController.text.isNotEmpty){
      name = nameController.text.toString();
    }

    if (savedMoney > totalValue){
      return "El valor guardado no puede ser mayor al total de la meta.";
    }

    if (isBeforeToday(dateController.text)){
      return "Fecha deseada no puede ser menor a la fecha de hoy";
    }

    final newGoal = Goal(name, dateController.text, 
                totalValue, savedMoney, defaultCouta, true);

    final newAccount = Account("Goal - "+ name, savedMoney, 2);
    DBProvider.db.database.then((db) => db.insert("accounts", newAccount.toJson()));
    DBProvider.db.database.then((db) => db.insert("goals", newGoal.toJson()));

    Navigator.pop(context);
    return "";
  }
}