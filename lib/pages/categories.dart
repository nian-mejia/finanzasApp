import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CategoriePage extends StatelessWidget {
  const CategoriePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorias"),
      ),
      body: getListView(),
    );
  }

  Widget getListView(){
    List<Icon> icons = getCategories();

    return ListView.builder(
      itemCount: icons.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(0.4.h),
          child: Column(
            children: [
              ListTile(
                title: Text("Category $index"),
                leading: TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.primaries[Random().nextInt(12)],
                    shape: const CircleBorder(),
                  ),
                  child: icons[index]),
                ),
                const Divider(),
            ],
          ),
        );
      });
  }

  List<Icon> getCategories(){
    List<Icon> data = [];
    data.add(const Icon(IconData(0xf316, fontFamily: 'MaterialIcons'),size:35, color: Colors.white,)); // restaurante
    data.add(const Icon(IconData(0xf016f, fontFamily: 'MaterialIcons'), size:35, color: Colors.white,)); // shoping bag
    data.add(const Icon(IconData(0xee4b, fontFamily: 'MaterialIcons'), size:35, color: Colors.white,)); // shoping cart
    data.add(const Icon(IconData(0xf7f5, fontFamily: 'MaterialIcons'), size:35, color: Colors.white,)); // house
    data.add(const Icon(IconData(0xe180, fontFamily: 'MaterialIcons'), size:35, color: Colors.white,)); // transportation
    data.add(const Icon(IconData(0xe299, fontFamily: 'MaterialIcons'), size:35, color: Colors.white,)); // travel
    data.add(const Icon(IconData(0xe643, fontFamily: 'MaterialIcons'), size:35, color: Colors.white,)); // comunicaciones
    data.add(const Icon(IconData(0xf0f2, fontFamily: 'MaterialIcons'), size:35, color: Colors.white,)); // health
    data.add(const Icon(IconData(0xf2f4, fontFamily: 'MaterialIcons'), size:35, color: Colors.white,)); // regalos
    data.add(const Icon(IconData(0xeea2, fontFamily: 'MaterialIcons'), size:35, color: Colors.white,)); // incomming
    data.add(const Icon(IconData(0xee71, fontFamily: 'MaterialIcons'), size:35, color: Colors.white,)); // others
    return data;
  }
}
