import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/services/auth/auth_service.dart';

class LoginController {
  final AuthService _authService;
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pass = TextEditingController();

  LoginController(this._authService);

  Future<void> signIn() async {
    if (formKey.currentState!.validate())
      await _authService.signin(email: email.text, password: pass.text);
  }
}
