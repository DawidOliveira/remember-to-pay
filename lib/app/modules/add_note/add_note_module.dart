import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/modules/add_note/add_note_controller.dart';
import 'package:remember_to_pay/app/modules/add_note/add_note_page.dart';

class AddNoteModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => AddNoteController(i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => AddNotePage(),
    )
  ];
}
