
import 'package:finances/models/goals.dart';

enum cuotas {
  Mensual,
  Semanal,
  Anual,
  Trimestral,
  Semestral
}

cuotas getCuotaByString(String? cuota){
  if (cuota == cuotas.Semanal.toString()){
    return cuotas.Semanal;
  }else if (cuota == cuotas.Mensual.toString()){
    return cuotas.Mensual;
  }else if (cuota == cuotas.Anual.toString()){
    return cuotas.Anual;
  }else if (cuota == cuotas.Trimestral.toString()){
    return cuotas.Trimestral;
  }else{
    return cuotas.Semestral;
  }
}

int getNumber(Goal card){
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

String getCuotaName(Goal card){
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
