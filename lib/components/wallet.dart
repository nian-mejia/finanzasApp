import 'dart:math';

import 'package:finances/constants/button_style.dart';
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
      ],
    ));
  }

  SingleChildScrollView _getGrid() {
    
    return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 1.5.h),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.32.h,
              mainAxisSpacing: 2.w,
              crossAxisSpacing: 20.0,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {

              final color = Colors.primaries[Random().nextInt(12)];
              final titleStyleColorBlue = TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color.shade50);

              return Container(
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
                      Text("Efectivo", style: titleStyleColorBlue,),
                      Text("\$ 1000", style: titleStyleColorBlue,),
                    ],
                  ),
              );
            },
          ),
        ),
      ],
    ));
  }
}