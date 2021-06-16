import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:remember_to_pay/app/modules/forgot_password/widgets/form_forgot_password_widget.dart';
import 'package:remember_to_pay/app/modules/forgot_password/widgets/logo_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends ModularState<ForgotPasswordPage, ForgotPasswordController>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LogoWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: FormForgotPasswordWidget(controller: controller),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
