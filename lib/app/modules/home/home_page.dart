import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/extensions/date_extension.dart';
import '../../shared/models/expense_model.dart';
import '../../shared/utils/utils_class.dart';
import 'home_bloc.dart';
import 'widgets/dismissible_background/dismissible_background_widget.dart';
import 'widgets/expenses_list_tile/expenses_list_tile_widget.dart';
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
    double statusBarHeight = MediaQuery.of(context).padding.top;
    Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: statusBarHeight + 20.0, left: 20.0),
            child: RichText(
              text: TextSpan(
                  text: "Hello,\n",
                  style: TextStyle(color: Colors.black, fontSize: 28),
                  children: [
                    TextSpan(
                      text: "Bruno!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<String>>(
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
                              this
                                  .controller
                                  .getTotalAmountFromFilteredExpenses(
                                      filteredExpenses),
                            ),
                            children:
                                _buildFilteredExpensesList(filteredExpenses),
                          );
                        }
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF42224A),
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
