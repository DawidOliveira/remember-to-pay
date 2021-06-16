import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/modules/signup/signup_controller.dart';
import 'package:remember_to_pay/app/modules/signup/signup_page.dart';

class SignupModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SignUpController(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => SignUpPage()),
  ];
}
