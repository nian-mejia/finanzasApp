import 'package:finances/components/budget.dart';
import 'package:finances/components/goals.dart';
import 'package:finances/components/wallet.dart';
import 'package:finances/constants/button_style.dart';
import 'package:finances/constants/titles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<InfoPage> {

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> _listViews = [_getBodyHome(), _getBodyInfo()];

    return Scaffold(
      appBar: _getAppBar(context),
      body: _listViews[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
            backgroundColor: colorApp
          ),
          BottomNavigationBarItem(
            label: "Info",
            icon: Icon(Icons.analytics),
            backgroundColor: colorApp,
          ),
        ],
        type: BottomNavigationBarType.shifting,
        iconSize: 32,
        onTap: (int index){   
          setState(() {
            currentIndex = index;
          });
        },
      ),
      floatingActionButton: currentIndex == 0 ? 
        FloatingActionButton(
          backgroundColor: ColorSelectAndButton,
          child: const Icon(Icons.add),
          onPressed: ()=>print("click floating")) : null,
    );
  }

  _getAppBar(BuildContext context) {

    final appBar =  AppBar(title: const Text(title), backgroundColor: colorApp,);

    return currentIndex == 0 ? PreferredSize(
      preferredSize: const Size.fromHeight(75.0),
      child:  Material(
        color: colorApp,
        elevation: 20 ,
        child: Container(
        child: _getTitleAppBar(),
        ),
    ),): appBar;
  }

  Column _getTitleAppBar() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(title, style: titleStyleBig,),
          Expanded(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start    ,
              children: [
                SizedBox(width: 6.w,),
                const Icon(Icons.savings, size: 35,),
                SizedBox(width: 3.w,),
                const Text("Saldo \$"),
                Text("122.000")
              ],
            ),
          )
        ],
      );
  }
}

Widget _getBodyHome(){
  return Center(child: Text("Home"),);
}

Widget _getBodyInfo(){

  return ListView(
          children: [
          WalletComponent(),
          const Divider(),
          Budget(),
          const Divider(),
          GoalsPage(),
          const Divider()
        ],
      );
}