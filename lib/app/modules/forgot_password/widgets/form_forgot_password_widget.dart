import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:remember_to_pay/app/modules/forgot_password/widgets/button_forgot_password_widget.dart';
import 'package:remember_to_pay/app/modules/forgot_password/widgets/input_signup_widget.dart';

class FormForgotPasswordWidget extends StatelessWidget {
  const FormForgotPasswordWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ForgotPasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Esqueceu a sua senha?',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Nós enviaremos um e-mail para que possas redefinir sua senha.',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(
            height: 30,
          ),
          InputForgotPasswordWidget.email(
            textEditingController: controller.email,
            validator: (value) {
              if (value != null && value.length > 5 && value.contains('@')) {
                return null;
              }
              return 'E-mail inválido, verifique se digitou corretamente!';
            },
          ),
          SizedBox(
            height: 30,
          ),
          ButtonForgotPasswordWidget(controller: controller),
        ],
      ),
    );
  }
}
