import 'package:flutter/material.dart';

import '../home_controller.dart';
import 'header_content_widget.dart';
import 'list_notes_widget.dart';

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderContentWidget(controller: controller),
          SizedBox(
            height: 20,
          ),
          ListNotesWidget(controller: controller)
        ],
      ),
    );
  }
}
