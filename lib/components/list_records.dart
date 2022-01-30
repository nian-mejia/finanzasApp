import 'package:finances/components/draw_records.dart';
import 'package:finances/models/records.dart';
import 'package:flutter/material.dart';

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
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index){
              return drawRecord(data[index]);
            }),
        );
      });   
  }

  
}