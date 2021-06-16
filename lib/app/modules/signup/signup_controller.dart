import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/repositories/user/user_repository.dart';
import 'package:remember_to_pay/app/services/auth/auth_service.dart';
import 'package:rx_notifier/rx_notifier.dart';

class SignUpController {
  final AuthService _authService;
  final UserRepository _userRepository;
  final name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final loading = RxNotifier<bool>(false);
  final widthButton = RxNotifier<double>(double.infinity);

  final formKey = GlobalKey<FormState>();

  SignUpController(this._authService, this._userRepository) {
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

  Future<void> signUpWithGoogle() async {
    await _authService.signUpWithGoogle();
  }

  Future<void> signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      loading.value = true;
      final response = await _userRepository.signUp(
        name: name.text,
        email: email.text,
        password: pass.text,
      );
      loading.value = false;

      if (response.runtimeType == FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.toString().split(']')[1]),
            backgroundColor: Colors.red,
            action: SnackBarAction(label: 'Fechar', onPressed: () {}),
          ),
        );
      }
    }
  }
}
