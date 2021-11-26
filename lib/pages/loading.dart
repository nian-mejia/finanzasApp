import 'package:finances/constants/titles.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  @override
  Widget build(BuildContext context) {

    print("object");
    return const Scaffold(
      backgroundColor: colorApp,
      body: Center(
        child: Image(image: NetworkImage("https://mir-s3-cdn-cf.behance.net/project_modules/max_632/04de2e31234507.564a1d23645bf.gif"),)),
    );
  }
}