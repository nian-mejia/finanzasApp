
import 'package:finances/models/budgets.dart';
import 'package:finances/provider/database.dart';
import 'package:finances/utils/date.dart';
import 'package:sqflite_common/sqlite_api.dart';

void updateBudgets() {

  getAllBudget().then((budgets) {

    DBProvider.db.database.then((db){
      final batch = db.batch();

      budgets.forEach((budget) {
        _updateSaldoBudget(batch, budget);
      });

      batch.commit();
    });
  });
}

void _updateSaldoBudget(Batch batch, Budget budget) {
  List<String> dates = getDates(budget.day);
  batch.rawUpdate(
    '''
      UPDATE budgets
      SET gastado = (
        SELECT sum(rc.value) as gastado
        from
        (SELECT *
        from records rc, 
        (SELECT b.*, bc.category
        from budgets b
        INNER join budget_has_category bc 
        on bc.budget = b.id
        where b.id = ?)  temp
        where temp.category = rc.category_id
        AND date BETWEEN date(?) 
        AND date(?)) rc
      )
      where id = ?;
    ''', [budget.id, dates[0], dates[1], budget.id]
  );
}

List<String> getDates(int day) {
  final today = DateTime.now();
  final currentMonth =  getDateFormated(DateTime(today.year, 
    today.month, day).toString());

  final rangeMonth = getDateFormated(DateTime(today.year, 
    today.day >= day ? today.month + 1 : 
    today.month - 1
    , day).toString());
  
  if (today.day > day){
    return [currentMonth, rangeMonth];
  }
  return [rangeMonth, currentMonth];
}
