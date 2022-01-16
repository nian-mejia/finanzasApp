import 'package:finances/constants/button_style.dart';
import 'package:finances/constants/titles.dart';
import 'package:finances/models/cuotas.dart';
import 'package:finances/models/goals.dart';
import 'package:finances/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GoalsGraph extends StatefulWidget {

  Goal? goal;

  GoalsGraph({Key? key, @required this.goal}) : super(key: key);

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
          _getHeader(widget.goal!),
          _getGraph(widget.goal!),
          _getInfoAboutDate(widget.goal!),
        ],
      ),
    );
  }

  Widget _getInfoAboutDate(Goal card){
    bool isTimeOutDate = isBeforeToday(card.endDate);
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final endDate = DateFormat('yyyy-MM-dd').parse(card.endDate);
    final duration = endDate.difference(today);
    var nCuotas = duration.inDays / getNumber(card);
    if (nCuotas == 0){
      nCuotas = 1;
    }

    double accountMin = 0;
    if (card.moneyEnd > card.moneySaved){
      accountMin = ( card.moneyEnd - card.moneySaved) / nCuotas; 
    }
    
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text("Cantidad mínima ${getCuotaName(card)} para llegar a la meta"),
          Text("COP ${accountMin.toStringAsFixed(0)}", style: titleStyleBigColorBlue,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25,),
              const Text("Número de cuotas ", style: titleStyle,),
              const SizedBox(width: 10,),
              isTimeOutDate &&  accountMin != 0 ? 
              const Text("1", style: titleStyleBigColorRed,):
              accountMin == 0 ? const Text("0", style: titleStyleBigColorBlue,) : 
              Text("${nCuotas.round()}", style: titleStyleBigColorBlue,),
            ],
          ),
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

  Widget _getHeader(Goal card){

    bool  isTimeOutDate = isBeforeToday(card.endDate);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events, size:50, color: colorSelectAndButton),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(card.title, style: titleStyleBig,),
                isTimeOutDate ? 
                Text("${card.endDate} CADUCADO", style: titleStyleBigColorRed,)
                : Text("Fecha limite ${card.endDate}"),
              ],
            ),
          )  
        ],
      ),
    );
  }
}