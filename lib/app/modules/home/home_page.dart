import 'package:expense_app/app/modules/home/widgets/new_expense/new_expense_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/extensions/money_extension.dart';
import '../../shared/models/expense_model.dart';
import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Expenses List"}) : super(key: key);

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
              Text(widget.title),
              StreamBuilder<List<ExpenseModel>>(
                stream: this.controller.outExpensesList,
                initialData: <ExpenseModel>[],
                builder: (context, snapshot) => snapshot.data.length == 0
                    ? Text(0.0.toMoney())
                    : Text(snapshot.data
                        .map((e) => e.value)
                        .reduce((value, element) => value + element)
                        .toMoney()),
              ),
            ]),
      ),
      body: StreamBuilder<List<ExpenseModel>>(
        stream: this.controller.outExpensesList,
        initialData: <ExpenseModel>[],
        builder: (context, snapshot) {
          if (snapshot.data.length == 0) {
            return Center(
              child: Text("No expenses added."),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                ExpenseModel item = snapshot.data[index];
                return ListTile(
                  title: Text(item.description),
                  subtitle: Text(DateTime.now().toString().split(" ")[0]),
                  trailing: Text(item.value.toMoney()),
                  leading: CircleAvatar(
                    child: Image.asset(
                      this.controller.imagesPath[item.serviceProvider],
                    ),
                  ),
                );
              },
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
        child: Icon(Icons.add),
      ),
    );
  }
}
