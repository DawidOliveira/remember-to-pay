import 'package:flutter/material.dart';

import '../add_note_controller.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AddNoteController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.desc,
      validator: controller.validatorDesc,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Descrição do lembrete...',
      ),
    );
  }
}
