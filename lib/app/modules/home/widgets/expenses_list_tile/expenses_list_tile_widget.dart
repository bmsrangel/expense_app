import 'package:flutter/material.dart';

import '../../../../shared/extensions/money_extension.dart';
import '../../../../shared/models/expense_model.dart';

class ExpensesListTileWidget extends StatelessWidget {
  final ExpenseModel expenseModel;
  final ValueChanged<ExpenseModel> onDismissed;
  final Widget dismissibleBackground;
  final Map serviceProviderImagePaths;
  final Function weekNumberFromDateCalculator;

  const ExpensesListTileWidget({
    Key key,
    this.expenseModel,
    this.onDismissed,
    this.dismissibleBackground,
    this.serviceProviderImagePaths,
    this.weekNumberFromDateCalculator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this.expenseModel.id.toString()),
      direction: DismissDirection.endToStart,
      background: this.dismissibleBackground,
      onDismissed: (direction) => this.onDismissed(this.expenseModel),
      child: ListTile(
        title: Text(this.expenseModel.description),
        subtitle: Text(this.weekNumberFromDateCalculator == null
            ? this.expenseModel.date
            : "${this.expenseModel.date} - W${this.weekNumberFromDateCalculator(DateTime.parse(this.expenseModel.date))}"),
        trailing: Text(this.expenseModel.value.toMoney()),
        leading: Image.asset(
          this.serviceProviderImagePaths[this.expenseModel.serviceProvider],
          width: 40,
        ),
      ),
    );
  }
}
