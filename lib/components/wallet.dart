import 'package:finances/constants/button_style.dart';
import 'package:flutter/material.dart';

class WalletComponent extends StatefulWidget {
  WalletComponent({Key? key}) : super(key: key);

  @override
  _WalletComponentState createState() => _WalletComponentState();
}

class _WalletComponentState extends State<WalletComponent> {

  final space = const SizedBox(height: 10,);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
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
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 8,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.amber,
              );
            },
          ),
        ),
      ],
    ));
  }
}