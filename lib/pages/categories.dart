import 'package:finances/models/category.dart';
import 'package:finances/components/icon.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CategoriePage extends StatelessWidget {
  const CategoriePage({Key? key}) : super(key: key);

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
                    leading: getIcon(categories[index]),
                    onTap: () => Navigator.pop(context, categories[index]),
                  ),
                  const Divider(),
              ],
            ),
          );
        });
      });    
  }
}
