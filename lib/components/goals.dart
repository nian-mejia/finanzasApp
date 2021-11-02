import 'package:finances/constants/button_style.dart';
import 'package:finances/models/carts.dart';
import 'package:finances/models/list/goal_list.dart';
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("OBJETIVOS", style: titleStyle),
          space,
          Column(
            children: _getCardByList(),
          ),
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

  List<Card> _getCardByList(){

    List<Card> response = [];

    cardList.forEach((card) {
      final cardTemp = _getCard(card);
      response.add(cardTemp);
    });
    
    return response;
  }

  Card _getCard(Cards card){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => GoalsGraph(card: card,)),
            );
          }, 
        child: Column(
          children: [
            _getHeader(card),
            space,
            _getBar(card),
            _getFooter(card),
          ],
        ),
      ),)
    );
  }
  _getFooter(Cards card){

    String ahorrado = "0";

    if (card.moneySaved != 0){
      ahorrado = card.moneySaved.toStringAsFixed(0);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical : 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Ahorrado \$ $ahorrado", 
              style: const TextStyle(color: Colors.green),),
          Text("Objetivo \$ ${card.moneyEnd.toStringAsFixed(0)}")
          // TODO: hacer que el dinero tenga las seraciones persos colombianos
        ],
      ),
    );  
  }

  LinearPercentIndicator _getBar(Cards card){
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
  Row _getHeader(Cards cards){
    return Row(
      children: [
        CircleAvatar(backgroundImage: cards.imagen,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cards.titulo, style: titleStyle,),
              Text("Fecha limite ${cards.endDate}")
            ],
          ),
        )  
      ],
    );
  }
}