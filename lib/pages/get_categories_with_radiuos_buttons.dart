import 'package:finances/constants/titles.dart';
import 'package:finances/models/category.dart';
import 'package:finances/pages/icon.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CategorieWithRadiuosButtonPage extends StatefulWidget {
  const CategorieWithRadiuosButtonPage({Key? key}) : super(key: key);

  @override
  State<CategorieWithRadiuosButtonPage> createState() => _CategorieWithRadiuosButtonPageState();
}

class _CategorieWithRadiuosButtonPageState extends State<CategorieWithRadiuosButtonPage> {
  Map<String, bool?> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorías"),
      ),
      body: getListView(),
    );
  }

  Widget getListView(){
    List<Category> categories = [];

    return FutureBuilder(
      initialData: categories,
      future: getCategories(),
      builder: (context, snapshoot){
        if (snapshoot.hasError){
          return const SizedBox();
        }
      categories = snapshoot.data as List<Category>; 
      return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(0.1.h),
            child: Column(
              children: [
                ListTile(
                  title: Text(categories[index].name),
                  leading: getIcon(categories, index),
                  trailing: Checkbox(
                    value: selectedCategories.containsKey("category_$index") ?
                    selectedCategories["category_$index"]:  false, 
                    onChanged: (bool? value) {
                      setState(() {
                        selectedCategories["category_$index"] = value;
                      });
                    },
                    activeColor: colorSelectAndButton,
                  )),
                  const Divider(),
              ],
            ),
          );
        });
      });    
  }
}
