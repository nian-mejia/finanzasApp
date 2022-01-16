import 'package:intl/intl.dart';

String getDateFormated(String text){
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

bool isBeforeToday(String date){
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final endDate = DateFormat('yyyy-MM-dd').parse(date);
    return endDate.isBefore(today);
}