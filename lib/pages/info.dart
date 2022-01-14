import 'package:finances/components/appbar.dart';
import 'package:finances/components/budget.dart';
import 'package:finances/components/goals.dart';
import 'package:finances/components/list_records.dart';
import 'package:finances/components/wallet.dart';
import 'package:finances/constants/titles.dart';
import 'package:finances/models/user.dart';
import 'package:finances/pages/recorder_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:sizer/sizer.dart';

class InfoPage extends StatefulWidget {
  User? googleUser;

  InfoPage(User? this.googleUser, {Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<InfoPage> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _listViews = [_getBodyHome(), _getBodyInfo()];
    final user = widget.googleUser;

    return Scaffold(
      appBar: AppbarPing(currentIndex, user).getAppBar(),
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
            _getFloatingActionButton()
          : null,
    );
  } 

  Widget _getFloatingActionButton(){
    return SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          visible: true,
          backgroundColor: colorSelectAndButton,
          elevation: 8.0,
          isOpenOnStart: false,
          animationSpeed: 200,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.compare_arrows),
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              label: 'Transacciones',
              visible: true,
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => 
                RecordedPage("Transferencias"))).
                then((value) => 
                    setState(() {
                }));
              },
            ),
            SpeedDialChild(
              child:  const Icon(Icons.attach_money, size: 30,) ,
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              label: 'Ingresos',
              onTap: () {
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => 
                  RecordedPage("Ingresos"))).
                  then((value) => 
                    setState(() {
                  }));
              },
            ),
            SpeedDialChild(
              child:  const Icon(Icons.shopping_cart),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Gastos',
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => 
                RecordedPage("Gastos"))).
                then((value) => 
                setState(() {
                }));
              },
            ),
          ],
        );
  }
  }

  Widget _getBodyHome(){
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: const Text("Últimos 30 días")),
        RecordsList(),
      ],
    );
  }

  Widget _getBodyInfo(){
    return ListView(
            children: [
            WalletComponent(),
            const Divider(),
            BudgetView(),
            const Divider(),
            GoalsPage(),
            const Divider()
          ],
        );
  }
