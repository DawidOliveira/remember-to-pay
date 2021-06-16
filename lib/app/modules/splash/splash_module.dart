import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/core/core.dart';
import 'package:remember_to_pay/app/modules/home/home_module.dart';
import 'package:remember_to_pay/app/modules/splash/splash_controller.dart';
import 'package:remember_to_pay/app/modules/splash/splash_page.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => SplashController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SplashPage()),
    ModuleRoute(
      AppRoute.HOME,
      module: HomeModule(),
    ),
  ];
}
