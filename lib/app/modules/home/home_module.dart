import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/core/core.dart';
import 'package:remember_to_pay/app/modules/add_note/add_note_module.dart';
import 'package:remember_to_pay/app/modules/home/home_controller.dart';
import 'package:remember_to_pay/app/modules/home/home_page.dart';
import 'package:remember_to_pay/app/modules/setting/setting_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController(i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ModuleRoute(AppRoute.ADD_NOTE, module: AddNoteModule()),
    ChildRoute(
      AppRoute.SETTINGS,
      child: (_, __) => SettingPage(),
    )
  ];
}
