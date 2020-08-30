import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool readOnly;
  final TextInputType keyboardType;
  final Widget prefix;
  final ValueChanged<String> validator;

  const CustomTextFieldWidget({
    Key key,
    this.controller,
    this.labelText,
    this.readOnly,
    this.keyboardType,
    this.prefix,
    this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: this.keyboardType,
      readOnly: this.readOnly ?? false,
      decoration: InputDecoration(
        labelText: this.labelText,
        prefix: this.prefix,
      ),
      validator: this.validator ??
          (value) {
            if (value.isEmpty) {
              return "Field must not be empty.";
            } else {
              return null;
            }
          },
    );
  }
}
