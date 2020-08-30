import 'package:flutter/material.dart';

import '../../../../shared/extensions/money_extension.dart';
import '../../../../shared/models/expense_model.dart';

class TotalAmountWidget extends StatelessWidget {
  final List<ExpenseModel> expensesList;

  const TotalAmountWidget({Key key, this.expensesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.expensesList.length == 0
        ? Text(0.0.toMoney())
        : Text(this
            .expensesList
            .map((e) => e.value)
            .reduce((value, element) => value + element)
            .toMoney());
  }
}
