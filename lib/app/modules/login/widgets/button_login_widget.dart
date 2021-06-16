import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/modules/login/login_controller.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ButtonLoginWidget extends StatefulWidget {
  const ButtonLoginWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  _ButtonLoginWidgetState createState() => _ButtonLoginWidgetState();
}

class _ButtonLoginWidgetState extends State<ButtonLoginWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RxBuilder(
        builder: (_) => AnimatedSize(
          duration: Duration(milliseconds: 200),
          vsync: this,
          curve: Curves.linear,
          child: Container(
            width: widget.controller.widthButton.value,
            height: 45,
            child: ElevatedButton(
              onPressed: () async {
                await widget.controller.signIn(context);
              },
              child: !widget.controller.loading.value
                  ? Text(
                      'ACESSAR',
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
