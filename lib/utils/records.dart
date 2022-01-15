import 'package:finances/models/budget_has_category.dart';
import 'package:finances/models/budgets.dart';
import 'package:finances/models/records.dart';
import 'package:finances/provider/database.dart';

void updateBudgets() async {
  Map<int?, Budget> budgetsMap = {};

  List<BudgetHasCategory> budgets = await getAllBudgetHasCategory();
    budgets.forEach((e) async {
      late int day;
      if (!budgetsMap.containsKey(e.budget)){
        final budget = await getBudgetByID(e.budget);
        budgetsMap[budget.id] = budget;
        day = budget.day;
      }

      // get records stay in range days
      final listRecords = await getRecordsInRangeDayAndWasExpense(day, e.categtory);
        
      double totalValue = 0;
      listRecords.forEach((record) { 
          totalValue += record.value;
      });
      final budget = budgetsMap[e.budget];
      budget!.gastado += totalValue;
        
    });

    budgetsMap.forEach((key, budget) { 
      _updateSaldoBudget(budget);
    });
}

void _updateSaldoBudget(Budget budget){
  DBProvider.db.database.then((db) => 
    db.update("budgets", budget.toJson()));
}


// ir por cada presupuesto 
// verificar los records que se unen con cada categoria
// sumar los gastos y
//actualizar los gastos de los últimos días teniendo en cuenta la fecha de corte

