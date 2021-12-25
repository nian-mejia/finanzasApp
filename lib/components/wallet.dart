import 'dart:math';

import 'package:finances/constants/button_style.dart';
import 'package:finances/models/accounts.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class WalletComponent extends StatefulWidget {
  WalletComponent({Key? key}) : super(key: key);

  @override
  _WalletComponentState createState() => _WalletComponentState();
}

class _WalletComponentState extends State<WalletComponent> {

  final space = SizedBox(height: 10.h,);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(maxSize),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("CUENTAS", style: titleStyle),
        _getGrid(),
        _getAddAccount(),
      ],
    ));
  }

  Widget _getAddAccount(){
    return 
    Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 1.5.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.add,
                  size : 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, 'addAccount');
                }
              ),
            ],
          ),
        ),
    );
  }

  Widget _getGrid() {
    List<Widget> accounts = [];
    return  FutureBuilder(
            builder: (context, snapshot) {
              final data  =  snapshot.data as List;
              if (snapshot.hasError || data.length == 0){
                  return SizedBox(height: 1.h, width: 100.w,);
                }
              for (var item in data as List<Account>) {
                accounts.add(createConteiner(item));
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  primary: false,
                  shrinkWrap: true, // use this
                  crossAxisSpacing: 5.w,
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.h,
                  childAspectRatio: (50.w /  10.h),
                  children: accounts,
                  ),
              );
              
            },
            future: getAccounts(),
            initialData: accounts,
     );
  }

  Container createConteiner(Account account){
    final color = Colors.primaries[Random().nextInt(12)];
    final titleStyleColorBlue = TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color.shade50);
    return 
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
                const Icon(
                Icons.payment_rounded,
                size : 25,
                color: Colors.white,
              ),
              Text(account.name, style: titleStyleColorBlue,),
              Text("\$ "+account.value, style: titleStyleColorBlue,),
            ],
          ),
      );
}
}