import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/models/expense_model.dart';
import '../../../../shared/utils/contants.dart';
import '../custom_text_field/custom_text_field_widget.dart';
import 'new_expense_bloc.dart';

class NewExpenseWidget extends StatelessWidget {
  final ValueChanged<ExpenseModel> onConfirm;
  final NewExpenseBloc controller = Modular.get<NewExpenseBloc>();

  NewExpenseWidget({Key key, this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("New Expense"),
      content: buildFormBody(context),
      actions: [
        FlatButton(
          child: Text("Cancel"),
          onPressed: this.controller.onCancelPressed,
        ),
        FlatButton(
          child: Text("Confirm"),
          onPressed: this.controller.onConfirmPressed,
        )
      ],
    );
  }

  Form buildFormBody(BuildContext context) {
    return Form(
      key: this.controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFieldWidget(
            controller: this.controller.origin$,
            labelText: "Origin",
          ),
          CustomTextFieldWidget(
            controller: this.controller.destination$,
            labelText: "Destination",
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFieldWidget(
                  controller: this.controller.expenseDate$,
                  readOnly: true,
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
          CustomTextFieldWidget(
            controller: this.controller.expenseValue$,
            keyboardType: TextInputType.number,
            labelText: "Value",
            prefix: Text("R\$ "),
          ),
          Row(
            children: [
              Text("Service Provider"),
              const SizedBox(width: 10.0),
              Expanded(
                child: StreamBuilder<String>(
                    stream: this.controller.outServiceProvider,
                    builder: (context, snapshot) {
                      return DropdownButton(
                        isExpanded: true,
                        onChanged: this.controller.setServiceProvider,
                        value: snapshot.data,
                        items: Utils.serviceProvidersImagePath.keys
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ),
                            )
                            .toList(),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
