import 'package:expense_app/app/shared/models/expense_model.dart';
import 'package:expense_app/app/shared/services/interfaces/local_storage_service_interface.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../shared/extensions/date_extension.dart';

class NewExpenseBloc extends Disposable {
  final ILocalStorageService _storage;
  NewExpenseBloc(this._storage);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController origin$ = TextEditingController();
  final TextEditingController destination$ = TextEditingController();
  final TextEditingController expenseDate$ =
      TextEditingController(text: DateTime.now().toString().split(" ")[0]);
  final TextEditingController expenseValue$ = TextEditingController();

  final BehaviorSubject<String> _serviceProvider$ = BehaviorSubject<String>();

  Sink<String> get inServiceProvider => this._serviceProvider$.sink;
  Stream<String> get outServiceProvider => this._serviceProvider$.stream;

  DateTime expenseDate;
  double expenseValue;
  String serviceProvider;

  void createExpense() {
    ExpenseModel newExpense = ExpenseModel(
      description: "${origin$.text} to ${destination$.text}",
      date: this.expenseDate?.getDate() ?? DateTime.now().getDate(),
      value: this.expenseValue,
      serviceProvider: this.serviceProvider,
    );
    this._storage.addExpense(newExpense);
  }

  void setExpenseDate(DateTime date) {
    this.expenseDate = date;
    this.expenseDate$.text = this.expenseDate.toString().split(" ")[0];
  }

  void setExpenseValue() {
    this.expenseValue =
        double.tryParse(this.expenseValue$.text.replaceAll(",", "."));
  }

  void setServiceProvider(String serviceProvider) {
    this.inServiceProvider.add(serviceProvider);
    this.serviceProvider = serviceProvider;
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    this.origin$.dispose();
    this.destination$.dispose();
    this.expenseDate$.dispose();
    this.expenseValue$.dispose();
    this._serviceProvider$.close();
  }
}
