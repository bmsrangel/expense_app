import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/extensions/money_extension.dart';
import '../../shared/models/expense_model.dart';
import '../../shared/services/interfaces/local_storage_service_interface.dart';

class HomeBloc extends Disposable {
  final ILocalStorageService _storageService;

  HomeBloc(this._storageService) {
    this.getAllExpenses().then((value) => this.setMonthsWithExpenses());
  }

  List<ExpenseModel> _expensesList;
  BehaviorSubject<List<ExpenseModel>> _expensesList$ =
      BehaviorSubject<List<ExpenseModel>>();
  Sink<List<ExpenseModel>> get inExpensesList => this._expensesList$.sink;
  Stream<List<ExpenseModel>> get outExpensesList => this._expensesList$.stream;

  Set<String> _monthsWithExpenses = Set<String>();
  BehaviorSubject<List<String>> _monthsWithExpenses$ =
      BehaviorSubject<List<String>>();
  Sink<List<String>> get inMonthsWithExpense => this._monthsWithExpenses$.sink;
  Stream<List<String>> get outMonthsWithExpense =>
      this._monthsWithExpenses$.stream;

  Future<void> getAllExpenses() async {
    List<ExpenseModel> auxExpensesList =
        await this._storageService.getAllExpenses();
    this._expensesList = List.from(auxExpensesList);
    this.inExpensesList.add(this._expensesList);
  }

  void setMonthsWithExpenses() {
    this._expensesList.forEach((element) {
      this._monthsWithExpenses.add(element.date.substring(0, 7));
    });
    this.inMonthsWithExpense.add(this._monthsWithExpenses.toList());
  }

  void onDismissed(ExpenseModel expense) async {
    await this._storageService.deleteExpense(expense);
    this._expensesList.removeWhere((element) => element.id == expense.id);
    this.inExpensesList.add(this._expensesList);
  }

  List<ExpenseModel> getFilteredExpenses(
      List<ExpenseModel> expensesList, String filter) {
    return expensesList
        .where((element) => element.date.contains(filter))
        .toList();
  }

  String getTotalAmountFromFilteredExpenses(List<ExpenseModel> expensesList) {
    return expensesList
        .map((e) => e.value)
        .reduce((value, element) => value + element)
        .toMoney();
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    this._expensesList$.close();
    this._monthsWithExpenses$.close();
  }
}
