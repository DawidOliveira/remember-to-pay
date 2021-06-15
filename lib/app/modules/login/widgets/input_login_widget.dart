import 'package:flutter/material.dart';

class InputLoginWidget extends StatefulWidget {
  const InputLoginWidget({
    Key? key,
    required this.hint,
    required this.textInputType,
    this.isPass = false,
    this.textEditingController,
    this.validator,
  }) : super(key: key);

  final String hint;
  final TextInputType textInputType;
  final bool isPass;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;

  InputLoginWidget.email(
      {this.hint = 'E-mail',
      this.textInputType = TextInputType.emailAddress,
      this.isPass = false,
      this.textEditingController,
      this.validator});

  InputLoginWidget.pass(
      {this.hint = 'Senha',
      this.textInputType = TextInputType.visiblePassword,
      this.isPass = true,
      this.textEditingController,
      this.validator});

  @override
  _InputLoginWidgetState createState() => _InputLoginWidgetState();
}

class _InputLoginWidgetState extends State<InputLoginWidget> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      obscureText: widget.isPass ? !_isVisible : false,
      validator: widget.validator,
      controller: widget.textEditingController,
      style: TextStyle(color: Colors.black),
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
