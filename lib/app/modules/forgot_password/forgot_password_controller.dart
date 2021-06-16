import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/services/auth/auth_service.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ForgotPasswordController {
  final AuthService _authService;
  final loading = RxNotifier<bool>(false);
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pass = TextEditingController();
  final widthButton = RxNotifier<double>(double.infinity);

  ForgotPasswordController(this._authService) {
    init();
  }

  void init() {
    loading.addListener(() async {
      if (loading.value) {
        widthButton.value = 75;
      } else {
        widthButton.value = double.infinity;
      }
    });
  }

  Future<void> sendEmail(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      loading.value = true;
      final response =
          await _authService.sendEmailForgotPassword(email: email.text);
      loading.value = false;

      if (response.runtimeType == FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.toString().split(']')[1]),
            backgroundColor: Colors.red,
            action: SnackBarAction(label: 'Fechar', onPressed: () {}),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('E-mail enviado com sucesso!'),
            backgroundColor: Colors.green,
            action: SnackBarAction(label: 'Fechar', onPressed: () {}),
          ),
        );
      }
    }
  }
}
