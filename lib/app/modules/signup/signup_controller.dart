import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/repositories/user/user_repository.dart';
import 'package:remember_to_pay/app/services/auth/auth_service.dart';

class SignUpController {
  final AuthService _authService;
  final UserRepository _userRepository;
  final name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();

  final formKey = GlobalKey<FormState>();

  SignUpController(this._authService, this._userRepository);

  Future<void> signUpWithGoogle() async {
    await _authService.signUpWithGoogle();
  }

  Future<void> signUp() async {
    if (formKey.currentState!.validate())
      await _userRepository.signUp(
        name: name.text,
        email: email.text,
        password: pass.text,
      );
  }
}
