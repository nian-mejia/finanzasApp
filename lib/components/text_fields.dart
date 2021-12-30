import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Padding getTextField(TextEditingController controller, String label) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 2.0.h),
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
    padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 2.0.h),
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
