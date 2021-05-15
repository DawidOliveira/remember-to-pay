import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/core/core.dart';

class SplashController extends Disposable {
  SplashController() {
    Future.delayed(Duration(seconds: 2), () {
      Modular.to.pushReplacementNamed(AppRoute.HOME);
    });
  }

  @override
  void dispose() {}
}
