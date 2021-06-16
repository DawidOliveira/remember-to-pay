import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remember_to_pay/app/modules/signup/signup_controller.dart';

class SignUpGoogleWidget extends StatelessWidget {
  const SignUpGoogleWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignUpController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () async {
          await controller.signUpWithGoogle();
        },
        icon: Icon(FontAwesomeIcons.googlePlusG),
        label: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Cadastre-se com o Google'),
        ),
      ),
    );
  }
}
