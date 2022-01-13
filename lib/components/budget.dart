import 'package:finances/constants/button_style.dart';
import 'package:finances/models/list/budget_list_graph.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class Budget extends StatefulWidget {
  Budget({Key? key}) : super(key: key);

  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {

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
      children : _extractBudget(),
  );
}

List<Widget> _extractBudget(){
  List<Widget> response = [];

  budgetsList.forEach((element) { 
    
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
    
    double _percent = element.gastado / element.totalMoney;

    final barIndicator = LinearPercentIndicator(
                percent: _percent > 1 ? 1 : _percent < 0 ? 0 : _percent,
                lineHeight: 20.0,
                center: Text("${_percent * 100}%"),
                linearStrokeCap: LinearStrokeCap.butt,
                backgroundColor: Colors.grey,
                progressColor: _percent < 1 ? Colors.blue
                  : Colors.red,
              );
    response..add(headers)
            ..add(SizedBox(height: 15,))
            ..add(barIndicator)
            ..add(SizedBox(height: 15,));
  });

  return response;
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