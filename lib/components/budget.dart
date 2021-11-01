import 'package:finances/models/budget_componets.dart';
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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTitle(),
          _getBugets(),
          _buttonAdd(),
        ],
    );
  }

Widget _getBugets(){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: maxPading),
    child: Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      direction: Axis.vertical,
      children : _extractBudget(),
    ),
  );
}

List<Widget> _extractBudget(){
  List<Widget> response = [];

  budgetsList.forEach((element) { 
    
    final text = Text(element.name, 
    style:  const TextStyle(fontWeight: FontWeight.bold),);
    
    final barIndicator = LinearPercentIndicator(
                percent: element.status / 100,
                lineHeight: 20.0,
                center: Text("${element.status}%"),
                linearStrokeCap: LinearStrokeCap.butt,
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              );
    response..add(text)
            ..add(SizedBox(height: 15,))
            ..add(barIndicator)
            ..add(SizedBox(height: 15,));
  });

  return response;
}

Widget _buttonAdd(){
  return ListTile(
    title: const Text("Nuevo presupuesto", 
      style: TextStyle(color: Colors.blue)),
    onTap: (){
      Navigator.pushNamed(context, "addPresupuesto").
      then((_) => setState(() {}));
    },
    leading: Icon(Icons.add_box_rounded),
  );
}

  Widget _getTitle(){
    const styleTitle = TextStyle(
      fontWeight: FontWeight.bold
    );

    return Padding(
      padding: EdgeInsets.all(maxPading),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("PRESUPUESTO", style: styleTitle,),
          Text("Administar")
        ],
      ),
    );
  }
}