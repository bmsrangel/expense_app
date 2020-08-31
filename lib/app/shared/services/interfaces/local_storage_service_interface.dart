import 'package:flutter_modular/flutter_modular.dart';

import '../../models/expense_model.dart';

abstract class ILocalStorageService implements Disposable {
  Future<List<ExpenseModel>> getAllExpenses();
  Future getExpenseByMonth(String month);
  Future<ExpenseModel> addExpense(ExpenseModel expense);
  Future deleteExpense(ExpenseModel expense);
  Future updateExpense(ExpenseModel expense);
}
