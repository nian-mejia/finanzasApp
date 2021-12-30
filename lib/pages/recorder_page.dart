import 'package:finances/components/text_fields.dart';
import 'package:finances/models/accounts.dart';
import 'package:finances/models/category.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
            key: _formKey,
            child:
            Column(
            children: [
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
    padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 2.0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Cuenta", style: TextStyle(fontWeight: FontWeight.bold),),
        TextField(
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
    padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 2.0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Categoría", style: TextStyle(fontWeight: FontWeight.bold),),
        TextField(
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
}