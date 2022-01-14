import 'package:finances/constants/button_style.dart';
import 'package:finances/models/budgets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class BudgetView extends StatefulWidget {
  BudgetView({Key? key}) : super(key: key);

  @override
  _BudgetViewState createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(maxSize),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTitle(),
            const SizedBox(height: maxSize,),
            _getBugets(),
            _buttonAdd(),
          ],
      )
    );
  }

Widget _getBugets(){
  return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.vertical,
      children : [
        _getBudget(),
        ],
  );
}

Widget _getBudget(){
  return FutureBuilder(
    future: getAllBudget(),
    builder: (context, snapshoot){
      if (snapshoot.hasError || snapshoot.data == null){
        return const SizedBox();
      }
      List<Widget> response = [];
      final budgets = snapshoot.data as List<Budget>;
      budgets.forEach((element) {
          Row headers = _getHeaders(element);
          LinearPercentIndicator barIndicator = _getBarIndicator(element);
          response..add(headers)
                  ..add(const SizedBox(height: 15,))
                  ..add(barIndicator)
                  ..add(const SizedBox(height: 15,));
        });     
        return Column(
          children: response,
        );
      });
}

LinearPercentIndicator _getBarIndicator(element) {
  double _percent = element.gastado / element.totalMoney;
  if (_percent.isNaN){
    _percent = 0;
  }
  final barIndicator = LinearPercentIndicator(
              percent: _percent >= 1 ? 1 : _percent <= 0 ? 0 : _percent,
              lineHeight: 20.0,
              center: Text("${(_percent * 100).toStringAsFixed(1)}%"),
              linearStrokeCap: LinearStrokeCap.butt,
              backgroundColor: Colors.grey,
              progressColor: _percent < 1 ? Colors.blue
                : Colors.red,
            );
  return barIndicator;
}

Row _getHeaders(element) {
  final text = Text(element.name, 
  style:  const TextStyle(fontWeight: FontWeight.bold),);
  
  final gastado = element.gastado == 0 ? "0" :
                  element.gastado.toStringAsFixed(0);
  
  final total = element.totalMoney.toStringAsFixed(0);
  final saldo = Text("$gastado / $total");
  
  final headers = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      text,
      saldo
    ],
  );
  return headers;
}

Widget _buttonAdd(){
  return ListTile(
    title: const Text("Nuevo presupuesto", 
      style: buttonTextStyle),
    onTap: (){
      Navigator.pushNamed(context, "addPresupuesto").
      then((_) => setState(() {}));
    },
    leading: iconButton,
  );
}

  Widget _getTitle(){
    const styleTitle = TextStyle(
      fontWeight: FontWeight.bold
    );

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("PRESUPUESTO", style: styleTitle,),
          Text("Administar")
        ],
      );
  }
}