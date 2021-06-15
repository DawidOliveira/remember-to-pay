import 'package:flutter/material.dart';

class InputSignUpWidget extends StatefulWidget {
  const InputSignUpWidget({
    Key? key,
    required this.hint,
    required this.textInputType,
    this.isPass = false,
    this.validator,
    required this.textCapitalization,
    this.textEditingController,
  }) : super(key: key);

  final String hint;
  final TextInputType textInputType;
  final bool isPass;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final TextEditingController? textEditingController;

  InputSignUpWidget.email(
      {this.hint = 'E-mail',
      this.textInputType = TextInputType.emailAddress,
      this.isPass = false,
      this.validator,
      this.textCapitalization = TextCapitalization.none,
      this.textEditingController});

  InputSignUpWidget.pass(
      {this.hint = 'Senha',
      this.textInputType = TextInputType.visiblePassword,
      this.isPass = true,
      this.validator,
      this.textCapitalization = TextCapitalization.none,
      this.textEditingController});

  @override
  _InputSignUpWidgetState createState() => _InputSignUpWidgetState();
}

class _InputSignUpWidgetState extends State<InputSignUpWidget> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      style: TextStyle(color: Colors.black),
      keyboardType: widget.textInputType,
      obscureText: widget.isPass ? !_isVisible : false,
      validator: widget.validator,
      textCapitalization: widget.textCapitalization,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: InputBorder.none,
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        suffixIcon: widget.isPass
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isVisible = !_isVisible;
                  });
                },
                icon: Icon(
                  _isVisible ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
    );
  }
}
