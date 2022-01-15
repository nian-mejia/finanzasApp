import 'package:finances/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

final padding = EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h);

Padding getTextField(TextEditingController controller, String label) {
  return Padding(
    padding: padding,
    child: Column(      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold),),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
          ),
        ),
      ],
    ),
  );
}

Padding getTextFieldValue(TextEditingController controller, String label) {
  return Padding(
    padding: padding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold),),
        TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration:   const InputDecoration(
              hintText: "0",
              icon: Icon(Icons.attach_money, size: 23,),
            ),
          ),
      ]
      ),
  );
}


_selectDate(BuildContext context, TextEditingController controller) async{
  final today = DateTime.now();

  final datePicker = await showDatePicker(
    context: context, 
    initialDate: today, 
    firstDate: DateTime(today.year-1), 
    lastDate: DateTime(today.year + 50),
    locale:  const Locale("es", "ES"),  
  );
  
  if (datePicker != null){
    controller.text = getDate(datePicker.toString());
  }
}


Padding getDataPicker(TextEditingController controller, 
  String label, BuildContext context){

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
      decoration: InputDecoration(
        hintText: label,
      ),
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate(context, controller);
      },
      ),
    ]
  ));
}