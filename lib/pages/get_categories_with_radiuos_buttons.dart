import 'package:finances/constants/titles.dart';
import 'package:finances/models/category.dart';
import 'package:finances/components/icon.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CategorieWithRadiuosButtonPage extends StatefulWidget {
  const CategorieWithRadiuosButtonPage({Key? key}) : super(key: key);

  @override
  State<CategorieWithRadiuosButtonPage> createState() => _CategorieWithRadiuosButtonPageState();
}

class _CategorieWithRadiuosButtonPageState extends State<CategorieWithRadiuosButtonPage> {
  Map<int, bool?> selectedCategories = {};
  List<Category> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorías"),
        actions: [
          TextButton(
            onPressed: _returnCategories(), 
            child: const Text("Guardar"))
        ],
      ),
      body: getListView(),
    );
  }

  Function() _returnCategories(){
    List<Category> categoriesCheck = [];
    return (){
      selectedCategories.forEach((key, value) {
        if (value == true){
          categoriesCheck.add(categories[key]);
        }
      });
      Navigator.pop(context, categoriesCheck);
    };
  }

  Widget getListView(){
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
                  leading: getIcon(categories[index]),
                  trailing: Checkbox(
                    value: selectedCategories.containsKey(index) ?
                    selectedCategories[index]:  false, 
                    onChanged: (bool? value) {
                      setState(() {
                        selectedCategories[index] = value;
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
