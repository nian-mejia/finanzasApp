class Budget {
  String name;
  double inicial;
  double gastado = 0;
  double status = 0;
  double saldo;

  Budget._(this.name,this.inicial, this.saldo);

  factory Budget(String name, double inicial){
    double saldo = inicial;
    return Budget._(name, inicial, saldo);
  }

}

