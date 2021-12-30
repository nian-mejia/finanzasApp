import 'package:finances/components/text_fields.dart';
import 'package:finances/constants/titles.dart';
import 'package:finances/models/accounts.dart';
import 'package:finances/models/category.dart';
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
                Navigator.pop(context);
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
              accountController.text = "${(account as Account).name} \$${(account as Account).value}";
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
            final account = await Navigator.pushNamed(context, "categories");
            if (account != null){
              categoryController.text = (account as Category).name;
            }
          },
      )
      ]));
  }

  String _saveRecord() {
    return "message";
  }
}