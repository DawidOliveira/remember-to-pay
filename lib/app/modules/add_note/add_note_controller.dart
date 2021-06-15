import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/modules/home/home_controller.dart';
import 'package:remember_to_pay/app/repositories/note/note_repository.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:uuid/uuid.dart';

class AddNoteController extends Disposable {
  final formKey = GlobalKey<FormState>();
  final desc = TextEditingController();
  final dateText = TextEditingController();
  final date = RxNotifier<DateTime>(DateTime.now());

  final HomeController _homeController;
  final NoteRepository _noteRepository;

  AddNoteController(this._homeController, this._noteRepository);

  Future<void> onSaved() async {
    if (formKey.currentState!.validate()) {
      final note = await _noteRepository.addNote(
        Uuid().v4(),
        desc.text,
        date.value,
      );

      if (note != null) {
        _homeController.setNoteInList(
          note,
        );
        Modular.to.pop();
      }
    }
  }

  String? validatorDesc(String? value) {
    if (value == null || value.length < 1) {
      return 'Descrição inválida';
    }
    return null;
  }

  @override
  void dispose() {}
}
