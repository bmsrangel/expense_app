import 'package:expense_app/app/shared/models/expense_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/services/interfaces/local_storage_service_interface.dart';

class HomeBloc extends Disposable {
  final ILocalStorageService _storageService;
  Map<String, String> imagesPath = {
    "99": "images/logo_99.png",
    "Uber": "images/logo_uber.png",
    "Taxi": "images/logo_taxi.png",
  };
  List<ExpenseModel> _expensesList = <ExpenseModel>[];
  HomeBloc(this._storageService) {
    this.getAllExpenses();
  }

  BehaviorSubject<List<ExpenseModel>> _expensesList$ =
      BehaviorSubject<List<ExpenseModel>>();
  Sink<List<ExpenseModel>> get inExpensesList => this._expensesList$.sink;
  Stream<List<ExpenseModel>> get outExpensesList => this._expensesList$.stream;

  void getAllExpenses() {
    this._storageService.getAllExpenses().then((value) {
      this._expensesList.clear();
      this._expensesList.addAll(value);
      this.inExpensesList.add(this._expensesList);
    });
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    this._expensesList$.close();
  }
}
