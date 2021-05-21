import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/modules/setting/setting_controller.dart';
import 'package:remember_to_pay/app/modules/setting/widgets/section_tile_widget.dart';
import 'package:remember_to_pay/app/shared/widgets/drawer_widget/drawer_widget.dart';
import 'package:rx_notifier/rx_notifier.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends ModularState<SettingPage, SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: DrawerWidget(controller: Modular.get()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configurações',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTileWidget(
                  label: 'Aplicativo',
                  icon: Icons.settings,
                ),
                RxBuilder(
                  builder: (context) => SwitchListTile.adaptive(
                    value: controller.darkMode.value,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    title: Text(
                      'Modo dark (ou não)',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    onChanged: controller.changeDarkMode,
                  ),
                ),
                SectionTileWidget(
                  label: 'Backup',
                  icon: Icons.backup,
                ),
                ListTile(
                  title: Text('Trazer os dados do banco de dados'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  onTap: () {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.confirm,
                      onConfirmBtnTap: () async {
                        await controller.syncDB(context);
                      },
                      title: 'Você tem certeza?',
                      text: 'Isso irá substituir os dados existentes.',
                      cancelBtnText: 'Cancelar',
                      onCancelBtnTap: () {
                        Modular.to.pop();
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
