import 'package:finances/constants/button_style.dart';
import 'package:finances/models/accounts.dart';
import 'package:finances/models/goals.dart';
import 'package:finances/models/cuotas.dart';
import 'package:finances/provider/database.dart';
import 'package:flutter/material.dart';

class AddGoalsPage extends StatefulWidget {
  AddGoalsPage({Key? key}) : super(key: key);

  @override
  _AddGoalsPageState createState() => _AddGoalsPageState();
}

class _AddGoalsPageState extends State<AddGoalsPage> {

  final nameController = TextEditingController();
  final valueController = TextEditingController();
  final savedController = TextEditingController();
  final dateController =  TextEditingController();

  final space = const SizedBox(height: 15);
  cuotas defaultCouta = cuotas.Mensual;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo objetivo"),
        actions: [
          TextButton(onPressed: 
            (){
              _saveGoal();
            }, child: const Text("Guardar")),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTextField(nameController,  "Nombre del objetivo"),
            space,          
            _getTextFieldValue(valueController, "Valor"),
            space,
            _getTextFieldValue(savedController, "Ya ahorrado"),
            space,
            _getDataPicker(dateController, "Fecha deseada"),
            space,
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

    return SizedBox(
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
    );
  }

  _selectDate() async{
    final today = DateTime.now();

    final datePicker = await showDatePicker(
      context: context, 
      initialDate: today, 
      firstDate: DateTime(today.year), 
      lastDate: DateTime(today.year + 50),
      locale:  const Locale("es", "ES")  
    );
    
    if (datePicker != null){
     dateController.text = "${datePicker.year}-${datePicker.month}-${datePicker.day}";
    }
  }

  TextField _getDataPicker(TextEditingController controller, String label){
   return TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
            ),
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
              _selectDate();
            },
            );
  }

  TextField _getTextField(TextEditingController controller, String label,) {
    return TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }

  TextField _getTextFieldValue(TextEditingController controller, String label) {
    return TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration:   InputDecoration(
              labelText: label,
              prefixIcon: const Icon(Icons.attach_money, size: 23,),
            ),
          );
  }

  _saveGoal(){
    double totalValue = 0;
    double savedMoney = 0;
    String name = "";

    if (valueController.text.isNotEmpty){
      totalValue = double.parse(valueController.text);
    }
    if (savedController.text.isNotEmpty){
      savedMoney = double.parse(savedController.text);
    }

    if (nameController.text.isNotEmpty){
      name = nameController.text.toString();
    }

    final newGoal = Goal(name, dateController.text, 
                totalValue, savedMoney, defaultCouta, true);

    final newAccount = Account("goal "+ name, savedMoney.toString(), 2);
    DBProvider.db.database.then((db) => db.insert("accounts", newAccount.toJson()));
    DBProvider.db.database.then((db) => db.insert("goals", newGoal.toJson()));

    Navigator.pop(context);
  }
}