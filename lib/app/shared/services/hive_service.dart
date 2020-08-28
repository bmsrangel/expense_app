import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../models/expense_model.dart';
import 'interfaces/local_storage_service_interface.dart';

@Injectable()
class HiveService implements ILocalStorageService {
  Completer<Box> completer = Completer<Box>();

  HiveService() {
    _init();
  }

  _init() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    final box = Hive.openBox("expenses");
    if (!completer.isCompleted) {
      this.completer.complete(box);
    }
  }

  @override
  Future<ExpenseModel> addExpense(ExpenseModel expense) async {
    final Box box = await this.completer.future;
    int expensesAmount = box.values.length;
    expense.id = expensesAmount;
    await box.put(expensesAmount, expense.toMap());
    return expense;
  }

  @override
  Future deleteExpense(ExpenseModel expense) async {
    final Box box = await this.completer.future;
    await box.deleteAt(expense.id);
  }

  @override
  Future getAllExpenses() async {
    final Box box = await this.completer.future;
    return box.values.map((item) => ExpenseModel.fromMap(item)).toList();
  }

  @override
  Future getExpenseByMonth(String month) {
    // TODO: implement getExpenseByMonth
    throw UnimplementedError();
  }

  @override
  Future updateExpense(ExpenseModel expense) async {
    final Box box = await this.completer.future;
    await box.put(expense.id, expense.toMap());
  }

  @override
  void dispose() async {
    final Box box = await this.completer.future;
    await box.close();
  }
}
