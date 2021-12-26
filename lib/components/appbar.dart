import 'package:finances/constants/button_style.dart';
import 'package:finances/constants/titles.dart';
import 'package:finances/models/accounts.dart';
import 'package:finances/models/user.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppbarPing extends StatelessWidget {
  int currentIndex;
  User? user;

  AppbarPing(this.currentIndex, this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetAppBar();
  }

  PreferredSizeWidget GetAppBar() {
  final appBar =  AppBar(title: const Text(title), backgroundColor: colorApp, automaticallyImplyLeading: false,);

  return currentIndex == 0 ? PreferredSize(
    preferredSize: const Size.fromHeight(100.0),
    child:  Material(
      color: colorApp,
      elevation: 20 ,
      child: _getTitleAppBar()),)
      : appBar;
  }

    Widget _getTitleAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(title, style: titleStyleBig,),
                CircleAvatar(
                  child:
                    ClipOval(
                  child:  user!.email!.isEmpty ? Image.network(user!.url!, color: Colors.amber,) 
                      : Image.network(user!.url!)
                ))
              ],
            ),
            _getIconAndBalance(),
          ],
        ),
    );
  }

  Widget _getIconAndBalance() {
    return  Row(
            children: [
              const Icon(Icons.savings, size: 35,),
              SizedBox(width: 3.w,),
              FutureBuilder(
                initialData: const Text("Saldo \$ 0"),
                future: getTotal(),
                builder: (context, snapshot) {
                  if (snapshot.hasError){
                    return const Text("Saldo \$ 0");
                  }
                  return Text("Saldo \$ ${snapshot.data}");
                }),
            ]
        );

  }
}