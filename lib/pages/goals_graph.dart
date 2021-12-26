import 'package:finances/constants/button_style.dart';
import 'package:finances/models/cuotas.dart';
import 'package:finances/models/goals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GoalsGraph extends StatefulWidget {

  Goal? card;

  GoalsGraph({Key? key, @required this.card}) : super(key: key);

  @override
  _GoalsGraphState createState() => _GoalsGraphState();
}

class _GoalsGraphState extends State<GoalsGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle del objetivo"),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
      ],),
      body: _getBody(),
    );
  }

  Widget _getBody(){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          _getHeader(widget.card!),
          _getGraph(widget.card!),
          _getInfoAboutDate(widget.card!),
        ],
      ),
    );
  }

  Widget _getInfoAboutDate(Goal card){

    final today = DateTime.now();
    final endDate = DateFormat('yyyy-MM-dd').parse(card.endDate);
    final duration = endDate.difference(today);
    final nCuotas = duration.inDays / getNumber(card);
    
    final accountMin = ( card.moneyEnd - card.moneySaved) / nCuotas; 
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text("Cantidad mínima ${getCuotaName(card)} para llegar a la meta"),
          Text("COP ${accountMin.toStringAsFixed(0)}", style: titleStyleBigColorBlue,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25,),
              const Text("Número de cuotas ", style: titleStyle,),
              SizedBox(width: 10,),
              Text("${nCuotas.round()}", style: titleStyleBigColorBlue,),

            ],
          )

        ],
      ),
    );
  }

  Widget _getGraph(Goal card){
    return CircularPercentIndicator(
                radius: 200.0,
                lineWidth: 16.0,
                animation: true,
                percent: card.percent,
                center:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${card.percent * 100} %",
                      style:
                        titleStyleBigColorBlue,
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      "${card.moneySaved.toStringAsFixed(0)} / ${card.moneyEnd.toStringAsFixed(0)}"
                    ),
                    const Text("COP")
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.blue,
              );
  }

  Row _getHeader(Goal cards){
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: 
          NetworkImage("https://thumbs.dreamstime.com/b/goals-icon-vector-red-target-arrow-achievement-concept-illustration-148419541.jpg"),
          radius: 34,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cards.title, style: titleStyleBig,),
              Text("Fecha limite ${cards.endDate}")
            ],
          ),
        )  
      ],
    );
  }
}