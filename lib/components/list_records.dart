import 'package:finances/components/draw_records.dart';
import 'package:finances/models/accounts.dart';
import 'package:finances/models/category.dart';
import 'package:finances/models/records.dart';
import 'package:finances/utils/format_value.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecordsList extends StatefulWidget {
  RecordsList({Key? key}) : super(key: key);

  @override
  _RecordsListState createState() => _RecordsListState();
}

class _RecordsListState extends State<RecordsList> {
  List<Record> data = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRecords(),
      builder: (context, snapshoot){
        if (snapshoot.hasError || !snapshoot.hasData){
          return const SizedBox();
        }
        data = (snapshoot.data as List<Record>);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index){
            return drawRecord(data[index]);
          });
      });   
  }

  
}