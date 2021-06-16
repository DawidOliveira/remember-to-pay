import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:remember_to_pay/app/modules/forgot_password/forgot_password_page.dart';

class ForgotPasswordModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ForgotPasswordController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => ForgotPasswordPage()),
  ];
}
