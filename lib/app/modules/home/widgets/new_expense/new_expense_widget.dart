import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import '../../../../shared/models/expense_model.dart';
import 'new_expense_bloc.dart';

class NewExpenseWidget extends StatelessWidget {
  final ValueChanged<ExpenseModel> onConfirm;
  final NewExpenseBloc controller = Modular.get<NewExpenseBloc>();

  NewExpenseWidget({Key key, this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("New Expense"),
      content: Form(
        key: this.controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: this.controller.origin$,
              decoration: InputDecoration(
                labelText: "Origin",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Field must not be empty.";
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: this.controller.destination$,
              decoration: InputDecoration(
                labelText: "Destination",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Field must not be empty.";
                } else {
                  return null;
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: this.controller.expenseDate$,
                    decoration: InputDecoration(
                      hintText: "Select date",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    ).then((value) => this.controller.setExpenseDate(value));
                  },
                )
              ],
            ),
            TextFormField(
              controller: this.controller.expenseValue$,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Value",
                prefix: Text("R\$ "),
              ),
            ),
            Row(
              children: [
                Text("Service Provider"),
                const SizedBox(width: 10.0),
                StreamBuilder<String>(
                    stream: this.controller.outServiceProvider,
                    builder: (context, snapshot) {
                      return DropdownButton(
                        onChanged: this.controller.setServiceProvider,
                        value: snapshot.data,
                        items: [
                          DropdownMenuItem(
                            child: Text("Uber"),
                            value: "Uber",
                          ),
                          DropdownMenuItem(
                            child: Text("99"),
                            value: "99",
                          ),
                          DropdownMenuItem(
                            child: Text("Taxi"),
                            value: "Taxi",
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Modular.to.pop();
          },
        ),
        FlatButton(
          child: Text("Confirm"),
          onPressed: () {
            if (this.controller.formKey.currentState.validate()) {
              this.controller.setExpenseValue();
              this.controller.createExpense();
              Modular.to.pop();
            }
          },
        )
      ],
    );
  }
}
