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
  final datePickerController = TextEditingController();
  late Category categorySelected;
  late Account accountSelected;

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
              _getCategory(),
              _getAccount(),
            ],
      ),)
    );
  }

  Padding _getAccount(){
    return Padding(
    padding: padding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Cuenta", style: TextStyle(fontWeight: FontWeight.bold),),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: accountController,
          autofocus: false,
          readOnly: true,
          decoration:  const InputDecoration(
                  labelText: "Selecciona una cuenta",
                  suffix: Icon(Icons.keyboard_arrow_down, size: 23,),
          ),
          onTap: () async {
            final account = await Navigator.pushNamed(context, "accounts");
            if (account != null){
              accountSelected = account as Account;
              accountController.text = "${accountSelected.name} \$${accountSelected.value}";
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
    if (widget.title == "Ingresos"){
      type = "ingreso";
    }else{
      type = "gasto";
    }

    final record = Record(date, description, value, categorySelected.id, accountSelected.id, type);
    DBProvider.db.database.then((db) => db.insert("records", record.toJson()));

    if (type == "ingreso"){
      accountSelected.value += value;
    }else{
      accountSelected.value -= value;
    }
    DBProvider.db.database.then((db) => db.update("accounts", accountSelected.toJson()));

    Navigator.pop(context);

    return "";
  }
}