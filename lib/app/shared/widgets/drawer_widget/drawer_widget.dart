import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/core/core.dart';
import 'package:remember_to_pay/app/shared/widgets/drawer_widget/drawer_widget_controller.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DrawerWidgetController controller;

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterLogo(
                    size: 50,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Remember to Pay',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'Home',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                onTap: () {
                  if (widget.controller.currentIndex.value != 0) {
                    widget.controller.changeCurrentIndex(0);
                    Modular.to.pushReplacementNamed(AppRoute.HOME);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Configurações',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                onTap: () {
                  if (widget.controller.currentIndex.value != 1) {
                    widget.controller.changeCurrentIndex(1);
                    Modular.to.pushReplacementNamed(AppRoute.SETTINGS);
                  }
                },
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Feito por Dáwid Silva',
              style: Theme.of(context).textTheme.overline,
            ),
          ),
        ],
      ),
    );
  }
}
