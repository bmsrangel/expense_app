import 'package:expense_app/app/modules/home/widgets/expenses_list/expenses_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/extensions/money_extension.dart';
import '../../shared/models/expense_model.dart';
import '../../shared/utils/contants.dart';
import 'home_bloc.dart';
import 'widgets/dismissible_background/dismissible_background_widget.dart';
import 'widgets/new_expense/new_expense_widget.dart';
import 'widgets/total_amount/total_amount_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc controller = Modular.get<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text("Expenses List"),
              StreamBuilder<List<ExpenseModel>>(
                stream: this.controller.outExpensesList,
                initialData: <ExpenseModel>[],
                builder: (context, snapshot) =>
                    TotalAmountWidget(expensesList: snapshot.data),
              ),
            ]),
      ),
      body: StreamBuilder<List<ExpenseModel>>(
        stream: this.controller.outExpensesList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: const CircularProgressIndicator(),
            );
          } else if (snapshot.data.length == 0) {
            return Center(
              child: const Text("No expenses added."),
            );
          } else {
            return ExpensesListWidget(
              expensesList: snapshot.data,
              dismissibleBackground: DismissibleBackgroundWidget(),
              onDismissed: this.controller.onDismissed,
              serviceProviderImagePaths: Utils.serviceProvidersImagePath,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => NewExpenseWidget(),
          );
          this.controller.getAllExpenses();
        },
        tooltip: 'Add expense',
        child: const Icon(Icons.add),
      ),
    );
  }
}
