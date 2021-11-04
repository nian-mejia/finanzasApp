import 'package:finances/components/budget.dart';
import 'package:finances/components/goals.dart';
import 'package:finances/components/wallet.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Finances"),),
      body: ListView(
          children: [
          WalletComponent(),
          const Divider(),
          Budget(),
          const Divider(),
          GoalsPage(),
          const Divider()
        ],
      ),
    );
  }
}