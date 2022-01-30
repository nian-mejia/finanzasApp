import 'package:finances/components/accounts.dart';
import 'package:finances/components/draw_records.dart';
import 'package:finances/models/accounts.dart';
import 'package:finances/models/records.dart';
import 'package:finances/provider/database.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BudgetDetails extends StatelessWidget {
  const BudgetDetails({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final updateAccount = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text("Detalles de cuenta"),
        actions: [
          _editAccount(context, updateAccount),
          _deleteAccount(context, updateAccount),
        ],),
      body: ListView(
        children: [
          _getAccount(updateAccount),
          const Divider(),
          _getListRecords(updateAccount)
        ]
      ),
    );
  }

  Padding _getAccount(Object? updateAccount) {
    return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
          child: drawAccount(Colors.blue, updateAccount as Account),
        );
  }

  Widget _deleteAccount(BuildContext context, Object? updateAccount) {
    return IconButton(onPressed: (){
      final account = updateAccount as Account;
      DBProvider.db.database.then((db) => 
        db.delete("accounts", where:  "id = ?", whereArgs: [account.id]));
        Navigator.pop(context);
    }, 
      icon:  
          const Icon(Icons.delete, color: Colors.red, size: 25,),
      );
  }

  Widget _editAccount(BuildContext context, Object? updateAccount) {
    return 
    IconButton(onPressed: ()=> 
        Navigator.popAndPushNamed(context, "addAccount", arguments: updateAccount), 
      icon: const Icon(Icons.edit, color: Colors.blue, size: 25,),);
  }

  Widget _getListRecords(Object? updateAccount) {
    final id = (updateAccount as Account).id;
    return FutureBuilder(
      future: getRecordsByAccount(id),
      builder: (builder, snapshoot){
        if (snapshoot.hasError || snapshoot.data == null){
          return const SizedBox();
        }

        final records = snapshoot.data as List<Record>;
        
        final drawRecords = records.map((e) => drawRecord(e)).toList();
        return Column(
          children: drawRecords,
        );
      });
  }
}