import 'dart:math';

import 'package:finances/models/accounts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cuentas"),
      ),
      body: getListView(),
    );
  }

  Widget getListView(){
    List<Account> accounts = [];
    return FutureBuilder(
      initialData: accounts,
      future: getAccounts(),
      builder: (context, snapshoot){
        if (snapshoot.hasError ){
          return const SizedBox();
        }
      accounts = snapshoot.data as List<Account>; 
      if (accounts.isEmpty){
        return  Center(
          child: Text("Por favor crea una cuenta primero", 
          style: TextStyle(color: Colors.red, fontSize: 2.h),),
        );
      }

      return ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(0.1.h),
            child: Column(
              children: [
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(accounts[index].name, 
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      Text("\$ ${accounts[index].value}"),
                    ],
                  ),
                  leading: TextButton(
                    onPressed: null,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.primaries[Random().nextInt(12)],
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.account_balance_wallet_rounded,
                      color: Colors.white,
                      size: 25,
                    )),
                    onTap: () => Navigator.pop(context, accounts[index]),
                  ),
                  const Divider(),
              ],
            ),
          );
        });
      });    
  }
}
