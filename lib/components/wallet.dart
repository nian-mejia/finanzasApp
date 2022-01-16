import 'dart:math';

import 'package:finances/constants/button_style.dart';
import 'package:finances/models/accounts.dart';
import 'package:finances/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class WalletComponent extends StatefulWidget {
  WalletComponent({Key? key}) : super(key: key);

  @override
  _WalletComponentState createState() => _WalletComponentState();
}

class _WalletComponentState extends State<WalletComponent> {

  final space = SizedBox(height: 1.h,);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(maxSize),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("CUENTAS", style: titleStyle),
        space,
        _getGrid(),
        _getAddAccount(),
      ],
    ));
  }

  Widget _getAddAccount(){
    return ListTile(
    title: const Text("Nueva cuenta", 
      style: buttonTextStyle),
    onTap: (){
      Navigator.pushNamed(context, "addAccount").
      then((_) => setState(() {}));
    },
    leading: iconButton,
  );
  }

  Widget _getGrid() {
    return  FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError || snapshot.data == null){
            return const SizedBox();
          }
          
          List<Account> data  =  snapshot.data as List<Account>;
          List<Widget> accounts = [];

          for (var item in data) {
            accounts.add(createConteiner(item));
          }
          if (accounts.isEmpty){
            return const SizedBox();
          }
          return GridView.count(
              shrinkWrap: true, // use this
              crossAxisSpacing: 5.w,
              crossAxisCount: 2,
              mainAxisSpacing: 1.h,
              childAspectRatio: (43.w /  10.h),
              children: accounts,
          );          
        },
        future: getAccounts(),
     );
  }

  Widget createConteiner(Account account){
    final color = Colors.primaries[account.id > 12 ? 
      Random().nextInt(12) : account.id];
    final titleStyleColorBlue = TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color.shade50);
    return 
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child:  Column(
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
}