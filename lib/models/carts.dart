// ignore_for_file: constant_identifier_names

import 'package:finances/models/cuotas.dart';
import 'package:flutter/material.dart';

class Cards{
  NetworkImage? imagen =  const NetworkImage("https://thumbs.dreamstime.com/b/goals-icon-vector-red-target-arrow-achievement-concept-illustration-148419541.jpg");
  String titulo;
  String endDate;
  double percent;
  double moneySaved;
  double moneyEnd;
  cuotas? cuota = cuotas.Mensual;

  Cards._(this.titulo, this.percent, this.moneySaved, this.moneyEnd, this.endDate, this.cuota);

  factory Cards(String title, String endDate,double moneyEnd, double moneySaved, cuotas? cuota){

    double percent = 0;

    if (moneySaved != 0){
      percent =  moneySaved / moneyEnd;
    }

    cuota ??= cuotas.Mensual;

    return Cards._(title, percent, moneySaved, moneyEnd, endDate, cuota);
  }
}

int getNumber(Cards card){
  switch (card.cuota) {
    case cuotas.Anual:
      return 365;
    case cuotas.Semestral:
      return 181;
    case cuotas.Trimestral:
      return 90;
    case cuotas.Mensual:
      return 30;
    case cuotas.Semanal:
      return 7;
    default:
      return -1;
  }
}


String getCardName(Cards card){
  switch (card.cuota) {
    case cuotas.Anual:
      return "anual";
    case cuotas.Semestral:
      return "semanal";
    case cuotas.Trimestral:
      return "trimestral";
    case cuotas.Mensual:
      return "mensual";
    case cuotas.Semanal:
      return "semanal";
    default:
      return "";
  }
}