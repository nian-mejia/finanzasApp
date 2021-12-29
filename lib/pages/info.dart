import 'package:finances/components/appbar.dart';
import 'package:finances/components/budget.dart';
import 'package:finances/components/goals.dart';
import 'package:finances/components/wallet.dart';
import 'package:finances/constants/titles.dart';
import 'package:finances/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
      appBar: AppbarPing(currentIndex, user).GetAppBar(),
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
        /*
        FloatingActionButton(
          backgroundColor: ColorSelectAndButton,
          child: const Icon(Icons.add),
          onPressed: () { 
            Navigator.pushNamed(context, "categories").
              then((value)
                {   
                setState(() {});
              });
            })*/
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
          backgroundColor: ColorSelectAndButton,
          //activeBackgroundColor: Colors.cyan,
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
              onTap: () {},
            ),
            SpeedDialChild(
              child:  const Icon(Icons.attach_money) ,
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              label: 'Ingresos',
              onLongPress: () {},
            ),
            SpeedDialChild(
              child:  const Icon(Icons.shopping_cart),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Gastos',
              onTap: () {},
            ),
          ],
        );
  }
  }

  Widget _getBodyHome(){
    return const Center(child: Text("Home"),);
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
