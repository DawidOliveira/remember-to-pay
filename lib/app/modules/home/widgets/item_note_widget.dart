import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/shared/models/note.dart';

import '../home_controller.dart';

extension CapExtension on String {
  String get inCaps =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get capitalizeFirstofEach => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str == 'de' ? 'de' : str.inCaps)
      .join(" ");
}

class ItemNoteWidget extends StatelessWidget {
  const ItemNoteWidget({
    Key? key,
    required this.controller,
    required this.note,
  }) : super(key: key);

  final HomeController controller;
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        onLongPress: () async {
          await CoolAlert.show(
            context: context,
            type: CoolAlertType.warning,
            confirmBtnText: 'Apagar',
            cancelBtnText: 'Cancelar',
            text: 'Tem certeza que deseja apagar?',
            title: 'Eiiii!!!',
            animType: CoolAlertAnimType.slideInLeft,
            showCancelBtn: true,
            onCancelBtnTap: () {
              Modular.to.pop();
            },
            onConfirmBtnTap: () {
              controller.removeNote(note);
              Modular.to.pop();
            },
          );
        },
        title: Text(
          'Todo dia ${note.date.day}',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        subtitle: Text(
          note.desc,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
