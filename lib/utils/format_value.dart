import 'package:intl/intl.dart';

String formatValue(double value){
  if (value == 0.0){
    return "\$ 0";
  }
  if (value.toString().length < 9){
    NumberFormat numberFormat =
    NumberFormat.currency(locale: "ar",
        symbol: "\$", decimalDigits: 0);
    return numberFormat.format(value);
  }
    NumberFormat numberFormat = NumberFormat.compact();
    return "\$ ${numberFormat.format(value)}";
}