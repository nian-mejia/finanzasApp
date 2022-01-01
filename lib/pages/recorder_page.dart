import 'package:finances/components/text_fields.dart';
import 'package:finances/constants/titles.dart';
import 'package:finances/models/accounts.dart';
import 'package:finances/models/category.dart';
import 'package:finances/models/records.dart';
import 'package:finances/provider/database.dart';
import 'package:flutter/material.dart';

class RecordedPage extends StatefulWidget {

  String title;

  RecordedPage(this.title, {Key? key}) : super(key: key);

  @override
  _RecordedPageState createState() => _RecordedPageState();
}

class _RecordedPageState extends State<RecordedPage> {

  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final valueController = TextEditingController();
  final categoryController = TextEditingController();
  final accountController = TextEditingController();
  final accountDestController = TextEditingController();
  final datePickerController = TextEditingController();
  late Category categorySelected;
  Account accountOriginSelected = Account("", 0, 0);
  Account accountDestSelected = Account("", 0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(onPressed: 
            (){
              if (_formKey.currentState!.validate()) {
                final message = _saveRecord();
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
            child:
            Column(
            children: [
              getDataPicker(datePickerController, "Fecha", context),
              getTextFieldValue(valueController, "Valor"),
              getTextField(descriptionController, "Descripción"),
              (widget.title != "Transferencias") ? 
               _getCategory() : const SizedBox(),
              (widget.title == "Transferencias") ? 
               _getAccount("Cuenta de origen", accountController, accountOriginSelected) 
               : _getAccount("Cuenta", accountController, accountOriginSelected),
              (widget.title == "Transferencias") ? 
               _getAccount("Cuenta de destino", accountDestController, accountDestSelected) 
               : const SizedBox(),
            ],
      ),)
    );
  }

  Padding _getAccount(String label, TextEditingController controller,
   Account accountSelect){
    return Padding(
    padding: padding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold),),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: controller,
          autofocus: false,
          readOnly: true,
          decoration:  const InputDecoration(
                  labelText: "Selecciona una cuenta",
                  suffix: Icon(Icons.keyboard_arrow_down, size: 23,),
          ),
          onTap: () async {
            final account = await Navigator.pushNamed(context, "accounts");
            if (account != null){
              accountSelect.id = (account as Account).id;
              accountSelect.name = (account as Account).name;
              accountSelect.value = (account as Account).value;
              accountSelect.visible = (account as Account).visible;
              controller.text = "${accountSelect.name} \$ ${accountSelect.value}";
            }
          },
      )
      ]));
  }

  Padding _getCategory(){
    return Padding(
    padding: padding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Categoría", style: TextStyle(fontWeight: FontWeight.bold),),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: categoryController,
          autofocus: false,
          readOnly: true,
          decoration:  const InputDecoration(
                  labelText: "Selecciona una categoria",
                  suffix: Icon(Icons.keyboard_arrow_down, size: 23,),
          ),
          onTap: () async {
            final category = await Navigator.pushNamed(context, "categories");
            if (category != null){
              categorySelected = category as Category;
              categoryController.text = categorySelected.name;
            }
          },
      )
      ]));
  }

  String _saveRecord() {
    final date = datePickerController.text;
    final description =  descriptionController.text;
    double value  = 0;
    if (valueController.text.isNotEmpty){
      try {
        value  = double.parse(valueController.text);
      }on FormatException{
        return "El campo valor debe ser númerico y sin puntos ni comas.";
      }
    }

    var type = "";
    
    switch (widget.title) {
    case "Ingresos":
      type = "ingreso";
      break;
    case "Gastos": 
       type = "gasto";
      break;
    case "Transferencias": 
       type = "transfer";
      break;
  }

    if (type == "ingreso"){
      accountOriginSelected.value += value;
    }if(type == "gasto"){
      accountOriginSelected.value -= value;
    }

    if (type != "transfer"){
      final record = Record(date, description, value, categorySelected.id, accountOriginSelected.id, null,  type);
      DBProvider.db.database.then((db) => db.insert("records", record.toJson()));
      DBProvider.db.database.then((db) => db.update("accounts", accountOriginSelected.toJson(),  where: "id = ${accountOriginSelected.id}"));
    }else{
      final record = Record(date, description, value, null, accountOriginSelected.id, accountDestSelected.id, type);
      DBProvider.db.database.then((db) => db.insert("records", record.toJson()));
      accountOriginSelected.value -= value;
      accountDestSelected.value += value;
      DBProvider.db.database.then((db) => db.update("accounts", accountOriginSelected.toJson(), where: "id = ${accountOriginSelected.id}"));
      DBProvider.db.database.then((db) => db.update("accounts", accountDestSelected.toJson(), where: "id = ${accountOriginSelected.id}"));
    }

    Navigator.pop(context);

    return "";
  }
}