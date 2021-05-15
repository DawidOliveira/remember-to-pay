import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/core/config.dart';
import 'package:remember_to_pay/app/core/core.dart';
import 'package:remember_to_pay/app/modules/splash/splash_controller.dart';
import 'package:rx_notifier/rx_notifier.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) => Scaffold(
        backgroundColor: Modular.get<Config>().theme.value == 0
            ? AppColors.WHITE
            : AppColors.DARK_COLOR,
        body: Center(
          child: FlutterLogo(
            size: 60,
          ),
        ),
      ),
    );
  }
}
