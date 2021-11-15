  import 'package:finances/routes/routes.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_localizations/flutter_localizations.dart';
  import 'package:sizer/sizer.dart';

  void main() => runApp(MyApp());

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Sizer(
        builder: (context, orientation, deviceType) {
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Finances app',
          theme: ThemeData.dark(),
          initialRoute: "login",
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