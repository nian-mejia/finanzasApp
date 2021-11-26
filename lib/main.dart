import 'package:finances/pages/loading.dart';
import 'package:finances/pages/login_page.dart';
import 'package:finances/provider/config.dart';
import 'package:finances/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Sizer(
        builder: (context, orientation, deviceType) {
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Finances app',
          theme: ThemeData.dark(),
          home: FutureBuilder(
            future: getConfigInicialized(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
               if (snapshot.hasError){
                 return const LoginPage();
               }
               return snapshot.data;
            },
            initialData: LoadingPage()
            ),
          routes: routes,
          localizationsDelegates: const [ 
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('es', ''), // Spanish, no country code
        ],
      );
      }
      );
  }
}