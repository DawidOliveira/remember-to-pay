import 'package:flutter/material.dart';
import 'package:remember_to_pay/app/modules/home/home_controller.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HeaderContentWidget extends StatelessWidget {
  const HeaderContentWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lembretes',
          style: Theme.of(context).textTheme.headline6,
        ),
        RxBuilder(
          builder: (context) => Text.rich(
            TextSpan(
              text: 'Você tem ',
              style: Theme.of(context).textTheme.caption,
              children: [
                TextSpan(
                  text: '${controller.list.value.length}',
                  style: Theme.of(context).textTheme.overline,
                ),
                TextSpan(
                  text: ' lembretes para hoje',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
