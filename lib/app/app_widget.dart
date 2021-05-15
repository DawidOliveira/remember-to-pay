import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/core/app_theme.dart';
import 'package:remember_to_pay/app/core/config.dart';
import 'package:rx_notifier/rx_notifier.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RxBuilder(builder: (_) {
      return MaterialApp(
        title: 'Remember to Pay',
        theme: Modular.get<Config>().theme.value == 0
            ? AppTheme.themeLight
            : AppTheme.themeDark,
        debugShowCheckedModeBanner: false,
      ).modular();
    });
  }
}
