
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
