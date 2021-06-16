import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:remember_to_pay/app/repositories/user/user_repository.dart';
import 'package:remember_to_pay/app/shared/models/user.dart';

import 'auth_service_interface.dart';

class AuthService implements IAuthService {
  final GoogleSignIn _googleSignIn;
  final UserRepository _userRepository;
  final FirebaseAuth _auth;

  AuthService(this._googleSignIn, this._userRepository, this._auth);

  Future<void> signUpWithGoogle() async {
    try {
      final value = await _googleSignIn.signIn();
      _userRepository.user.value = UserModel(
        id: value!.id,
        name: value.displayName!,
        email: value.email,
      );
      await _userRepository.saveDataUser(
        id: value.id,
        name: value.displayName!,
        email: value.email,
      );
      Modular.to.pushReplacementNamed('/home');
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> sendEmailForgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('sendEmailForgotPassword $e');
      return e;
    }
  }

  Future<void> signinWithGoogle() async {
    try {
      final value = await _googleSignIn.signIn();
      _userRepository.user.value = UserModel(
        id: value!.id,
        name: value.displayName!,
        email: value.email,
      );
      Modular.to.pushReplacementNamed('/home');
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signin(
      {required String email, required String password}) async {
    try {
      final value = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _userRepository.user.value = UserModel(
        id: value.user!.uid,
        name: value.user!.displayName!,
        email: value.user!.email!,
      );
      await _userRepository.saveLocalUser(
        id: value.user!.uid,
        name: value.user!.displayName!,
        email: value.user!.email!,
      );
      await _userRepository.saveDataUser(
        id: value.user!.uid,
        name: value.user!.displayName!,
        email: value.user!.email!,
      );
      Modular.to.pushReplacementNamed('/home');
    } catch (e) {
      print('signin $e');
      return e;
    }
  }

  Future<void> signOut() async {
    try {
      await _userRepository.clearLocalData();
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      if (_auth.currentUser != null) {
        await _auth.signOut();
      }
      Modular.to.pushReplacementNamed('/login');
    } catch (e) {
      throw e;
    }
  }
}
