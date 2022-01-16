import 'package:finances/constants/button_style.dart';
import 'package:finances/constants/titles.dart';
import 'package:finances/models/goals.dart';
import 'package:finances/pages/goals_graph.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GoalsPage extends StatefulWidget {
  GoalsPage({Key? key}) : super(key: key);

  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final space = const SizedBox(height:10);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(maxSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("OBJETIVOS", style: titleStyle),
          space,
          _getGoalsByList(),
          _addButton(),
        ]
      ),
    );
  }

  Widget _addButton(){
    return ListTile(
    title: const Text("Nuevo objetivo", 
      style: buttonTextStyle),
    onTap: (){
      Navigator.pushNamed(context, "addGoals").
      then((_) => setState(() {}));
    },
    leading: iconButton,
  );
  }

  Widget _getGoalsByList() {
    return FutureBuilder(
      future: getGoals(),
      builder: (context, snapshoot){
        List<Widget> response = [];
        if (snapshoot.hasData){
          List<Goal> goals   =  snapshoot.data as List<Goal>;
          goals.forEach((goal) {
            final cardTemp = _getCard(goal);
            response.add(cardTemp);
          });
          return Column(
            children: response,
          );
        }
        return Column();
      },);
  }

  Widget _getCard(Goal goal){
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: InkWell(
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => GoalsGraph(goal: goal,)),
            );
          }, 
        child: Column(
          children: [
            _getHeader(goal),
            space,
            _getBar(goal),
            _getFooter(goal),
          ],
        ),
      )
    );
  }
  _getFooter(Goal goal){

    String ahorrado = "0";

    if (goal.moneySaved != 0){
      ahorrado = goal.moneySaved.toStringAsFixed(0);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical : 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Ahorrado \$ $ahorrado", 
              style: const TextStyle(color: Colors.green),),
          Text("Objetivo \$ ${goal.moneyEnd.toStringAsFixed(0)}")
          // TODO: hacer que el dinero tenga las seraciones persos colombianos
        ],
      ),
    );  
  }

  LinearPercentIndicator _getBar(Goal card){
    return LinearPercentIndicator(
            percent: card.percent,
            lineHeight: 20.0,
            center: Text("${card.percent * 100}%"),
            linearStrokeCap: LinearStrokeCap.butt,
            backgroundColor: Colors.grey,
            progressColor: card.percent < 100 ? Colors.blue
              : Colors.red,
          );
  }
  Row _getHeader(Goal goal){
    return Row(
      children: [
        const Icon(Icons.emoji_events, size:35, color: colorSelectAndButton) 
        ,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(goal.title, style: titleStyle,),
              Text("Fecha limite ${goal.endDate}")
            ],
          ),
        ), 
      ],
    );
  }
}