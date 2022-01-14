import 'package:finances/models/budget_has_category.dart';
import 'package:finances/models/category.dart';
import 'package:finances/provider/database.dart';

void updateBudgets(double value, Category category) async {
  List<BudgetHasCategory> budgets = await getAllBudgetHasCategory(category.id);
    budgets.forEach((budget) {
      DBProvider.db.database.then((db) => 
        db.rawUpdate(
          '''
          UPDATE budgets 
          SET gastado = gastado + $value 
          WHERE id = ${budget.budget};
          '''
        )
        );
    });
}
