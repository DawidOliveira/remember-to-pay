import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/core/core.dart';
import 'package:remember_to_pay/app/repositories/user/user_repository.dart';
import 'package:rx_notifier/rx_notifier.dart';

class SplashController extends Disposable {
  final widthLogo = RxNotifier<double>(0);
  final durationInMilliseconds = 1000;
  final UserRepository _userRepository;

  SplashController(this._userRepository) {
    init();
    Future.delayed(Duration(seconds: 2), () {
      if (_userRepository.user.value != null)
        Modular.to.pushReplacementNamed(AppRoute.HOME);
      else
        Modular.to.pushReplacementNamed(AppRoute.LOGIN);
    });
  }

  Future<void> init() async {
    await Future.delayed(Duration(milliseconds: durationInMilliseconds));
    widthLogo.value = 220;
  }

  @override
  void dispose() {}
}
