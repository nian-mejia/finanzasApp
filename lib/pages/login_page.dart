import 'package:finances/models/user.dart';
import 'package:finances/pages/info.dart';
import 'package:finances/provider/database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DBProvider.db.database;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 28.h,
            child:  
            Image.asset("images/charco.png", height: 18.h, width: 80.w,
            color: Colors.lightBlue)
          ),
          Positioned(
            top: 11.h,
            child:  
            Image.asset("images/marranito.png", height: 28.h,)
          ),
          Positioned(
            top: 45.h,
            child:
          const Text("¿Dónde deseas guardar la infromación?",
            style: TextStyle(fontWeight: FontWeight.bold))),
          Positioned(
            top: 50.h,
            child:
          _googleLogin(context)  
          ),
          Positioned(
            top:  58.h,
            child:
            _saveInDevice(context)
          ),
        ],
      ),
    );
  }

  ElevatedButton _saveInDevice(BuildContext context) {
    return ElevatedButton(
          style: ElevatedButton.styleFrom(
              onSurface: Colors.white,
              primary: Colors.blue.shade400,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),
          onPressed: (){
             Navigator.push(context,  
                  MaterialPageRoute(builder: (context) => InfoPage(null)),);
          }, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.phone_android),
              SizedBox(width: 20),
              Text("Save in your device"),
            ],
          )
        );
  }

  ElevatedButton _googleLogin(BuildContext context) {
    return ElevatedButton(
          style: ElevatedButton.styleFrom(
              onSurface: Colors.white,
              primary: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),
          onPressed: () async{
            try {
                final googleUser = await GoogleSignIn().signIn();
                User user = User(googleUser);
                if (user.email != null){
                  DBProvider.db.database.then((db) => db.insert("users", user.toJson()));
                }
                Navigator.push(context,  
                  MaterialPageRoute(builder: (context) => InfoPage(user)),);
            } catch (error) {
              return;
            }

          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset("images/google.png", height: 2.5.h, color: Colors.white),
              const SizedBox(width: 20),
              const Text("Sign in with Google",
               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ],
          )
        );
  }
}