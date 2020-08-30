import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/models/expense_model.dart';
import '../../shared/services/interfaces/local_storage_service_interface.dart';

class HomeBloc extends Disposable {
  final ILocalStorageService _storageService;
  List<ExpenseModel> _expensesList;
  HomeBloc(this._storageService) {
    this.getAllExpenses();
  }

  BehaviorSubject<List<ExpenseModel>> _expensesList$ =
      BehaviorSubject<List<ExpenseModel>>();
  Sink<List<ExpenseModel>> get inExpensesList => this._expensesList$.sink;
  Stream<List<ExpenseModel>> get outExpensesList => this._expensesList$.stream;

  void getAllExpenses() {
    this._storageService.getAllExpenses().then((value) {
      if (this._expensesList == null) {
        this._expensesList = List.from(value);
      } else {
        this._expensesList.clear();
        this._expensesList.addAll(value);
      }
      this.inExpensesList.add(this._expensesList);
    });
  }

  void onDismissed(ExpenseModel expense) async {
    await this._storageService.deleteExpense(expense);
    this._expensesList.removeWhere((element) => element.id == expense.id);
    this.inExpensesList.add(this._expensesList);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    this._expensesList$.close();
  }
}
