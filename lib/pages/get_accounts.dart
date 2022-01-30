import 'dart:math';

import 'package:finances/models/accounts.dart';
import 'package:finances/utils/format_value.dart';
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
      body: getListView(context),
    );
  }

  Widget getListView(context){
    List<Account> accounts = [];
    String allAccounts = ModalRoute.of(context)!.settings.arguments as String;

    return FutureBuilder(
      initialData: accounts,
      future: allAccounts.isEmpty ?  getAccounts() :  getAllAccounts(),
      builder: (context, snapshoot){
        if (snapshoot.hasError ){
          return const SizedBox();
        }
      accounts = snapshoot.data as List<Account>; 
      if (accounts.isEmpty){
        return  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async { 
                  final message = await Navigator.pushNamed(context, "addAccount");
                  if (message.toString() == "OK"){
                    Navigator.pop(context);
                  }
                },
                child: Text("Por favor crea una cuenta primero", 
                  style: TextStyle(color: Colors.white, fontSize: 2.h),),)
            ],
          ),
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
                      Text(formatValue(accounts[index].value)),
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
                  trailing:  accounts[index].visible == 1 ? SizedBox(
                    width: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text("Privada"),
                        Icon(Icons.lock_outline, size: 16,)
                      ],
                    ),
                  ) : const SizedBox(),
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
