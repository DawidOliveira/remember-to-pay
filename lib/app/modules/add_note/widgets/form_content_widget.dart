import 'package:flutter/material.dart';

import '../add_note_controller.dart';
import 'input_date_widget.dart';
import 'input_text_widget.dart';

class FormContentWidget extends StatelessWidget {
  const FormContentWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AddNoteController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            InputTextWidget(controller: controller),
            SizedBox(
              height: 10,
            ),
            InputDateWidget(controller: controller)
          ],
        ),
      ),
    );
  }
}
