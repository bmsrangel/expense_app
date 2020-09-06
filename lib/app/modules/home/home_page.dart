import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/extensions/date_extension.dart';
import '../../shared/models/expense_model.dart';
import '../../shared/utils/utils_class.dart';
import 'home_bloc.dart';
import 'widgets/dismissible_background/dismissible_background_widget.dart';
import 'widgets/expenses_list/expenses_list_tile_widget.dart';
import 'widgets/new_expense/new_expense_widget.dart';

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
        title: const Text("Expenses List"),
      ),
      body: StreamBuilder<List<String>>(
        stream: this.controller.outMonthsWithExpense,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) =>
                  StreamBuilder<List<ExpenseModel>>(
                stream: this.controller.outExpensesList,
                builder: (context, snapshot2) {
                  if (!snapshot2.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<ExpenseModel> filteredExpenses = this
                        .controller
                        .getFilteredExpenses(
                            snapshot2.data, snapshot.data[index]);
                    return ExpansionTile(
                      title: Text(snapshot.data[index]
                          .convertToMonthAndYear(Utils.monthsOfTheYear)),
                      trailing: Text(
                        this.controller.getTotalAmountFromFilteredExpenses(
                            filteredExpenses),
                      ),
                      children: _buildFilteredExpensesList(filteredExpenses),
                    );
                  }
                },
              ),
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

  List<Widget> _buildFilteredExpensesList(List<ExpenseModel> filteredExpenses) {
    return filteredExpenses
        .map<Widget>(
          (expense) => ExpensesListTileWidget(
            expenseModel: expense,
            dismissibleBackground: DismissibleBackgroundWidget(),
            onDismissed: this.controller.onDismissed,
            serviceProviderImagePaths: Utils.serviceProvidersImagePath,
            weekNumberFromDateCalculator: Utils.getWeekNumberFromDate,
          ),
        )
        .toList();
  }
}
