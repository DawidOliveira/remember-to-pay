import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/core/app_colors.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.WHITE),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Calendário',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: AppColors.WHITE,
              ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: AppColors.WHITE,
              ),
              onPressed: () async {
                await controller.signOut();
              },
            ),
          )
        ],
      ),
      drawer: DrawerWidget(controller: Modular.get()),
      body: HomeContentWidget(controller: controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Modular.to.pushNamed('${AppRoute.HOME}${AppRoute.ADD_NOTE}');
        },
        child: Icon(
          Icons.add,
          color: AppColors.WHITE,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
