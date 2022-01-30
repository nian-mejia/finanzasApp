import 'package:finances/models/accounts.dart';
import 'package:finances/utils/format_value.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget drawAccount(MaterialColor color, Account account){
  final titleStyleColorBlue = TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color.shade50);
  return Container(
          height: 10.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ), 
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                    const Icon(
                    Icons.payment_rounded,
                    size : 25,
                    color: Colors.white,
                  ),
                  Text(account.name, style: titleStyleColorBlue,),
                  Text(formatValue(account.value), 
                    style: titleStyleColorBlue,
                      overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
          );
}