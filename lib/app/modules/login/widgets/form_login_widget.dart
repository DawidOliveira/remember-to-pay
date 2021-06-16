import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/modules/login/login_controller.dart';
import 'package:remember_to_pay/app/modules/login/widgets/button_login_widget.dart';
import 'package:remember_to_pay/app/modules/login/widgets/forgot_password_button_widget.dart';
import 'package:remember_to_pay/app/modules/login/widgets/input_login_widget.dart';
import 'package:remember_to_pay/app/modules/login/widgets/login_google_widget.dart';
import 'package:remember_to_pay/app/modules/login/widgets/or_divider_widget.dart';

class FormLoginWidget extends StatelessWidget {
  const FormLoginWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FAÇA O LOGIN',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          InputLoginWidget.email(
            validator: (value) {
              if (value != null && value.length > 5 && value.contains('@')) {
                return null;
              }
              return 'E-mail inválido, verifique se digitou corretamente!';
            },
            textEditingController: controller.email,
          ),
          SizedBox(
            height: 20,
          ),
          InputLoginWidget.pass(
            validator: (value) {
              if (value != null && value.length > 5) {
                return null;
              }
              return 'Senha inválida, deve conter no mínimo 6 caracteres!';
            },
            textEditingController: controller.pass,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ForgotPasswordButtonWidget(),
          ),
          SizedBox(
            height: 10,
          ),
          ButtonLoginWidget(controller: controller),
          SizedBox(
            height: 20,
          ),
          OrDividerWidget(),
          SizedBox(
            height: 20,
          ),
          LoginGoogleWidget(),
        ],
      ),
    );
  }
}
