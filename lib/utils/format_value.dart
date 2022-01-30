import 'package:intl/intl.dart';

String formatValue(double value, {bool short=false}){
  if (value == 0.0){
    return "\$ 0";
  }
  if (value.toString().length < 9 || short){
    NumberFormat numberFormat =
      NumberFormat.currency(locale: "ar",
        symbol: "\$", decimalDigits: 0);
      return numberFormat.format(value).replaceAll(",", ".");
  }
    NumberFormat numberFormat = NumberFormat.compact();
    return "\$ ${numberFormat.format(value).replaceAll(",", ".")}";
}