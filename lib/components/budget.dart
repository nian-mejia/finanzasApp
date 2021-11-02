import 'package:finances/constants/button_style.dart';
import 'package:finances/models/list/budget_list.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class Budget extends StatefulWidget {
  Budget({Key? key}) : super(key: key);

  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {

  double maxPading = 20.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(maxPading),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTitle(),
            SizedBox(height: maxPading,),
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
                    element.gastado.toStringAsFixed(3);

    final inicial = element.inicial.toStringAsFixed(3);
    final saldo = Text("$gastado / $inicial");

    final headers = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text,
        saldo
      ],
    );
    
    double _percent = 1;

    if (element.status <= 100){
      _percent = element.status  / 100;
    }

    final barIndicator = LinearPercentIndicator(
                percent: _percent,
                lineHeight: 20.0,
                center: Text("${element.status}%"),
                linearStrokeCap: LinearStrokeCap.butt,
                backgroundColor: Colors.grey,
                progressColor: element.status < 100 ? Colors.blue
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