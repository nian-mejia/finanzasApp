
import 'package:finances/models/accounts.dart';
import 'package:finances/models/cuotas.dart';
import 'package:finances/provider/database.dart';
import 'package:flutter/material.dart';

class AddAccountPage extends StatefulWidget {
  AddAccountPage({Key? key}) : super(key: key);

  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {

  final nameController = TextEditingController();
  final valueController = TextEditingController();

  final space = const SizedBox(height: 15);
  cuotas defaultCouta = cuotas.Mensual;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva cuenta"),
        actions: [
          TextButton(onPressed: 
            (){
              _saveAccount();
              Navigator.pop(context);
            }, child: const Text("Guardar")),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTextField(nameController, "Nombre de la cuenta"),
            space,          
            _getTextFieldValue(valueController, "Saldo inicial"),
            space,
            //TODO: excluirSaldo
          ],
        ),
      ),
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

  _saveAccount(){
    String value = "0";

    if (valueController.text.isNotEmpty){
      value = valueController.text.toString();
    }

    Account account = Account(nameController.text, value);
    DBProvider.db.database.then((db) => db.insert("accounts", account.toJson()));
  }
}