import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/core/app_route.dart';
import 'package:remember_to_pay/app/shared/widgets/drawer_widget/drawer_widget.dart';

import 'home_controller.dart';
import 'widgets/home_content_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          )
        ],
      ),
      drawer: DrawerWidget(controller: Modular.get()),
      body: HomeContentWidget(controller: controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Modular.to.pushNamed('${AppRoute.HOME}${AppRoute.ADD_NOTE}');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
