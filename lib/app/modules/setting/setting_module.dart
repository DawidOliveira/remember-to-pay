import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/modules/setting/setting_controller.dart';
import 'package:remember_to_pay/app/modules/setting/setting_page.dart';

class SettingModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => SettingController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => SettingPage(),
    )
  ];
}
