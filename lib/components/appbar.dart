import 'package:finances/constants/button_style.dart';
import 'package:finances/constants/titles.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';

class AppbarPing extends StatelessWidget {
  int currentIndex;
  GoogleSignInAccount? user;

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
                  child:  user != null ? Image.network(user!.photoUrl!)
                     : Image.network("http://cdn.onlinewebfonts.com/svg/img_184513.png",
                      color: Colors.amber,)
                ))
              ],
            ),
            _getIconAndBalance(),
          ],
        ),
    );
  }

  Row _getIconAndBalance() {
    return Row(
            children: [
              const Icon(Icons.savings, size: 35,),
              SizedBox(width: 3.w,),
              const Text("Saldo \$"),
              Text("122.000")
            ],
          );
  }
}