import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/modules/home/home_controller.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'item_note_widget.dart';

class ListNotesWidget extends StatelessWidget {
  const ListNotesWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          controller.config.theme.value == 0 ? Colors.grey[100] : Colors.grey,
      padding: const EdgeInsets.all(5),
      child: RxBuilder(
        builder: (context) => ListView.builder(
          itemCount: controller.list.value.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final note = controller.list.value[index];
            return ItemNoteWidget(controller: controller, note: note);
          },
        ),
      ),
    );
  }
}
