class Budget {
  String name;
  double inicial;
  double gastado = 0;
  double status = 0;
  double saldo;
  int day;

  Budget._(this.name,this.inicial, this.saldo, this.day);

  factory Budget(String name, double inicial, int date){
    double saldo = inicial;
    return Budget._(name, inicial, saldo, date);
  }

}

