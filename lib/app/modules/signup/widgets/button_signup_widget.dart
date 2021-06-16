import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/modules/signup/signup_controller.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ButtonSignupWidget extends StatefulWidget {
  const ButtonSignupWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignUpController controller;

  @override
  _ButtonSignupWidgetState createState() => _ButtonSignupWidgetState();
}

class _ButtonSignupWidgetState extends State<ButtonSignupWidget>
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
                await widget.controller.signUp(context);
              },
              child: !widget.controller.loading.value
                  ? Text(
                      'CADASTRAR',
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
