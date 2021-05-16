import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../add_note_controller.dart';

class InputDateWidget extends StatelessWidget {
  const InputDateWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AddNoteController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
          initialDatePickerMode: DatePickerMode.day,
        );
        if (selectedDate == null) return;
        controller.dateText.text =
            'Todo dia: ${DateFormat('dd').format(selectedDate)} você será notificado!';
        controller.date.value = selectedDate.add(Duration(hours: 9));
      },
      child: TextFormField(
        controller: controller.dateText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Escolha uma data...',
        ),
        enabled: false,
      ),
    );
  }
}
