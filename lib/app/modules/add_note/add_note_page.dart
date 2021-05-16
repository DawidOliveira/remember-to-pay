import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/core/core.dart';
import 'package:remember_to_pay/app/modules/add_note/add_note_controller.dart';

import 'widgets/form_content_widget.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends ModularState<AddNotePage, AddNoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 5,
        title: Text(
          'Adicionar novo lembrete',
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: AppColors.GREY,
          ),
          onPressed: () {
            Modular.to.pop();
          },
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(
                  horizontal: 30,
                ),
              ),
            ),
            onPressed: controller.onSaved,
            child: Text('Salvar'),
          ),
        ],
      ),
      body: FormContentWidget(controller: controller),
    );
  }
}
