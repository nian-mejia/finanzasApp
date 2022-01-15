import 'package:intl/intl.dart';

String getDate(String text){
  final date = DateFormat('yyyy-MM-dd').
      parse(text).toString();
  return _subtractDate(date);
}

 String _subtractDate(String date){
  RegExp regExp = RegExp("\\d{4}-\\d{2}-\\d{2}");
  final match = regExp.firstMatch(date);
  final value = match?.group(0);
  return value!;
}