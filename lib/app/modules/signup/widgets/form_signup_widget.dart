import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/modules/signup/signup_controller.dart';
import 'package:remember_to_pay/app/modules/signup/widgets/button_signup_widget.dart';
import 'package:remember_to_pay/app/modules/signup/widgets/input_signup_widget.dart';
import 'package:remember_to_pay/app/modules/signup/widgets/or_divider_widget.dart';
import 'package:remember_to_pay/app/modules/signup/widgets/signup_google_widget.dart';

class FormSignupWidget extends StatelessWidget {
  const FormSignupWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignUpController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CADASTRE-SE',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          InputSignUpWidget(
            textEditingController: controller.name,
            hint: 'Nome completo',
            textInputType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value != null && value.length > 3) {
                return null;
              }
              return 'O nome deve ter mais de 3 caracteres!';
            },
          ),
          SizedBox(
            height: 20,
          ),
          InputSignUpWidget.email(
            textEditingController: controller.email,
            validator: (value) {
              if (value != null && value.length > 5 && value.contains('@')) {
                return null;
              }
              return 'E-mail inválido, verifique se digitou corretamente!';
            },
          ),
          SizedBox(
            height: 20,
          ),
          InputSignUpWidget.pass(
            textEditingController: controller.pass,
            validator: (value) {
              if (value != null && value.length > 5) {
                return null;
              }
              return 'A senha deve ter mais de 6 caracteres!';
            },
          ),
          SizedBox(
            height: 30,
          ),
          ButtonSignupWidget(controller: controller),
          SizedBox(
            height: 20,
          ),
          OrDividerWidget(),
          SizedBox(
            height: 20,
          ),
          SignUpGoogleWidget(controller: controller),
        ],
      ),
    );
  }
}
