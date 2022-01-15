
import 'package:finances/models/budget_has_category.dart';
import 'package:finances/provider/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

Future<void> updateBudgets() async {

  DBProvider.db.database.then((db) async {
    db.rawUpdate(
    '''
      UPDATE budgets
      SET gastado = (select sum(rc.value) as gastado
      from
      (SELECT * FROM records
      WHERE category_id = 3
      AND date BETWEEN date("2021-12-30") 
      AND date("2022-01-30")) rc,
      budget_has_category bc, budgets b
      where  bc.budget = b.id and b.id = 2
      and rc.category_id = bc.category)
      where id = 2;
    '''
  );
  });
}

void _updateSaldoBudget(Batch batch, BudgetHasCategory budget) {
  batch.rawUpdate(
    '''
      UPDATE budgets
      SET gastado = (select sum(rc.value) as gastado
      from
      (SELECT * FROM records
      WHERE category_id = ${budget.categtory}
      AND date BETWEEN date("2021-12-30") 
      AND date("2022-01-30")) rc,
      budget_has_category bc, budgets b
      where  bc.budget = b.id and b.id = ${budget.budget}
      and rc.category_id = bc.category)
      where id = ${budget.budget};
    '''
  );
}
