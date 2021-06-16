import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ButtonForgotPasswordWidget extends StatefulWidget {
  const ButtonForgotPasswordWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ForgotPasswordController controller;

  @override
  _ButtonForgotPasswordWidgetState createState() =>
      _ButtonForgotPasswordWidgetState();
}

class _ButtonForgotPasswordWidgetState extends State<ButtonForgotPasswordWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RxBuilder(
        builder: (_) => AnimatedSize(
          duration: Duration(milliseconds: 300),
          vsync: this,
          curve: Curves.linear,
          child: SizedBox(
            width: widget.controller.widthButton.value,
            height: 45,
            child: ElevatedButton(
              onPressed: () async {
                await widget.controller.sendEmail(context);
              },
              child: !widget.controller.loading.value
                  ? Text(
                      'ENVIAR',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
