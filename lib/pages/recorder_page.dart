import 'package:finances/components/text_fields.dart';
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
            ],
      ),)
    );
  }

  Padding _getCategory(){
    return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Categoría", style: TextStyle(fontWeight: FontWeight.bold),),
        TextField(
          controller: categoryController,
          autofocus: false,
          readOnly: true,
          decoration:  const InputDecoration(
                  labelText: "Selectiona la categoria",
                  suffix: Icon(Icons.keyboard_arrow_down, size: 23,),
          ),
          onTap: () async {
            final category = await Navigator.pushNamed(context, "categories");
            if (category != null){
              categoryController.text = (category as Category).name;
            }
          },
      )
      ]));
  }
}