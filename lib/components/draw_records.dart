import 'package:finances/models/accounts.dart';
import 'package:finances/models/category.dart';
import 'package:finances/models/records.dart';
import 'package:finances/utils/format_value.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget drawRecord(Record record){
  return InkWell(onTap: () {}, 
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
        child:  Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getIconAndNameCategory(record),
              _getValueAndDate(record),
            ],
          ),
        ),
    );
}

FutureBuilder _getIconAndNameCategory(Record data) {
    final space = SizedBox(width: 6.w,);
    return FutureBuilder(
      future: getCategoryByID(data.category),
      builder: (context, snapshoot){
        if (snapshoot.hasData){
          Category categoryResponse =  snapshoot.data as Category;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getIcon(categoryResponse, data.type),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(categoryResponse.name, 
                    style: const TextStyle(fontWeight: FontWeight.bold),),
                  _getAccount(data.accountOrigin),
                  Text(data.description, overflow: TextOverflow.ellipsis),
                ],
              )
            ],
          );
        }
        return Row(
          children:  [
            CircleAvatar(
              backgroundColor: colorsRecord[data.type],
              child:
              const Icon(
                Icons.compare_arrows,
                color: Colors.white,
                size: 30,)),
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Transacción", style: TextStyle(fontWeight: FontWeight.bold)),
                _getAccount(data.accountOrigin),
                Text(data.description, overflow: TextOverflow.ellipsis,),
              ],
            )
          ],
        );
      });
  }

  Widget _getIcon(Category categoryResponse, String type) {
    return CircleAvatar(
            backgroundColor: colorsRecord[type],
            child: Icon(
                IconData(categoryResponse.icon, fontFamily: 'MaterialIcons'),
                color: Colors.white,
                size: 30,
              ),
    );
  }

  _getValueAndDate(Record data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("COP ${formatValue(data.value)}", style: TextStyle(
          color: colorsRecord[data.type], overflow: TextOverflow.ellipsis
        ),),
        Text(data.date),
      ],
    );
  }

  FutureBuilder _getAccount(int? accountOrigin) {
    return FutureBuilder(
      future: getAccountById(accountOrigin),
      builder: (context, snapshoot){
        if (snapshoot.hasData){
          return Text((snapshoot.data as Account).name);
        }
        return const SizedBox();
      });
  }