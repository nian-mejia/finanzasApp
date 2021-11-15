import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 28.h,
            child:  
            Image.asset("images/charco.png", height: 20.h,
            color: Colors.blue)
          ),
          Positioned(
            top: 10.h,
            child:  
            Image.asset("images/marranito.png", height: 30.h,)
          ),
          Positioned(
            top: 45.h,
            child:
          const Text("¿Dónde deseas guardar la infromación?",
            style: TextStyle(fontWeight: FontWeight.bold))),
          Positioned(
            top: 50.h,
            child:
          _googleLogin()
          ),
          Positioned(
            top:  62.h,
            child:
            _saveInDevice()
          ),
        ],
      ),
    );
  }

  ElevatedButton _saveInDevice() {
    return ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.blue.shade400,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),
          onPressed: (){}, 
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

  ElevatedButton _googleLogin() {
    return ElevatedButton(
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.red,
              primary: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),
          onPressed: (){}, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset("images/google.png", height: 4.h,),
              SizedBox(width: 20),
              const Text("Sign in with Google",
               style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
            ],
          )
        );
  }
}