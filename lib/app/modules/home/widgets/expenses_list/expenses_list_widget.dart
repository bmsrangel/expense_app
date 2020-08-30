import 'package:flutter/material.dart';

import '../../../../shared/extensions/money_extension.dart';
import '../../../../shared/models/expense_model.dart';

class ExpensesListWidget extends StatelessWidget {
  final List<ExpenseModel> expensesList;
  final ValueChanged<ExpenseModel> onDismissed;
  final Widget dismissibleBackground;
  final Map serviceProviderImagePaths;

  const ExpensesListWidget(
      {Key key,
      this.expensesList,
      this.onDismissed,
      this.dismissibleBackground,
      this.serviceProviderImagePaths})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.expensesList.length,
      itemBuilder: (_, index) {
        ExpenseModel item = this.expensesList[index];
        return Dismissible(
          key: Key(item.id.toString()),
          direction: DismissDirection.endToStart,
          background: this.dismissibleBackground,
          onDismissed: (direction) => this.onDismissed(item),
          child: ListTile(
            title: Text(item.description),
            subtitle: Text(item.date),
            trailing: Text(item.value.toMoney()),
            leading: Image.asset(
              this.serviceProviderImagePaths[item.serviceProvider],
              width: 40,
            ),
          ),
        );
      },
    );
  }
}
