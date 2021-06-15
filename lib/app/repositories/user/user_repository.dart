import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/repositories/user/user_repository_interface.dart';
import 'package:remember_to_pay/app/shared/models/user.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository implements IUserRepository {
  final user = RxNotifier<UserModel?>(null);
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  SharedPreferences? _ps;

  UserRepository(this._firebaseAuth, this._firestore) {
    init();
  }

  Future<void> init() async {
    _ps = await SharedPreferences.getInstance();
    try {
      if (_ps!.getString('user') != null) {
        user.value = UserModel.fromJson(_ps!.getString('user')!);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _ps = await SharedPreferences.getInstance();
    try {
      final value = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await value.user!.updateDisplayName(name);
      await saveDataUser(id: value.user!.uid, name: name, email: email);
      user.value = UserModel(id: value.user!.uid, name: name, email: email);
      await saveLocalUser(email: email, id: value.user!.uid, name: name);
      Modular.to.pushReplacementNamed('/home');
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveDataUser(
      {required String id, required String name, required String email}) async {
    await _firestore.collection('users').doc(id).set({
      'name': name,
      'email': email,
    });
  }

  Future<void> saveLocalUser(
      {required String id, required String name, required String email}) async {
    _ps = await SharedPreferences.getInstance();
    try {
      final value = UserModel(id: id, name: name, email: email);
      await _ps!.setString('user', value.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> clearLocalData() async {
    _ps = await SharedPreferences.getInstance();
    try {
      await _ps!.remove('user');
    } catch (e) {
      throw e;
    }
  }
}
