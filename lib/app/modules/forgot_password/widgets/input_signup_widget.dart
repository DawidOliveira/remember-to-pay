import 'package:flutter/material.dart';

class InputForgotPasswordWidget extends StatefulWidget {
  const InputForgotPasswordWidget({
    Key? key,
    required this.hint,
    required this.textInputType,
    this.validator,
    required this.textCapitalization,
    this.textEditingController,
  }) : super(key: key);

  final String hint;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final TextEditingController? textEditingController;

  InputForgotPasswordWidget.email(
      {this.hint = 'E-mail',
      this.textInputType = TextInputType.emailAddress,
      this.validator,
      this.textCapitalization = TextCapitalization.none,
      this.textEditingController});

  @override
  _InputForgotPasswordWidgetState createState() =>
      _InputForgotPasswordWidgetState();
}

class _InputForgotPasswordWidgetState extends State<InputForgotPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      style: TextStyle(color: Colors.black),
      keyboardType: widget.textInputType,
      validator: widget.validator,
      textCapitalization: widget.textCapitalization,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: InputBorder.none,
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
    );
  }
}
