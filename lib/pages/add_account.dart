
import 'package:finances/constants/titles.dart';
import 'package:finances/models/accounts.dart';
import 'package:finances/models/cuotas.dart';
import 'package:finances/provider/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAccountPage extends StatefulWidget {
  AddAccountPage({Key? key}) : super(key: key);

  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {

  final nameController = TextEditingController();
  final valueController = TextEditingController();
  bool isVisible = true;

  final space = const SizedBox(height: 15);
  cuotas defaultCouta = cuotas.Mensual;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva cuenta"),
        actions: [
          TextButton(onPressed: 
            (){
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                if (_saveAccount()){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(backgroundColor: colorApp,
                    content: Text('El valor debe ser númerico y sin puntos.', 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                  );
                }
              }
            }, child: const Text("Guardar")),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getTextField(nameController, "Nombre de la cuenta"),
              space,          
              _getTextFieldValue(valueController, "Saldo inicial"),
              space,
              _excludeField()
            ],
        ),
        ),
      )
    );
  }

  Widget _excludeField(){
    return Row(
      children: [
        const Text("Incluir en el saldo total", style: 
          TextStyle(fontWeight: FontWeight.bold),),
        Switch(value: isVisible,
            onChanged: (value) {
              setState(() {
                isVisible = value;
              });
            },),
      ],
    );
  }
  
  TextField _getTextField(TextEditingController controller, String label) {
    return TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }

  TextFormField _getTextFieldValue(TextEditingController controller, String label) {
    return TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration:   InputDecoration(
              labelText: label,
              prefixIcon: const Icon(Icons.attach_money, size: 23,),
            ),
          );
  }

  bool _saveAccount(){
    String value = "0";
    String name  = "Account";
    int visible = 1;

    if (valueController.text.isNotEmpty){
      value = valueController.text.toString();
      try {
        double.parse(value);
      }on FormatException{
        return true;
      }
    }

    if (nameController.text.isNotEmpty){
      name = nameController.text;
    }

    if (isVisible == true){
      visible = 1;
    }else{
      visible = 0;
    }

    Account account = Account(name, value, visible);
    DBProvider.db.database.then((db) => db.insert("accounts", account.toJson()));
    Navigator.popAndPushNamed(context, "info");
    return false;
    }
}