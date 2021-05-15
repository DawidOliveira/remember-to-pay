import 'package:remember_to_pay/app/core/config.dart';
import 'package:rx_notifier/rx_notifier.dart';

class SettingController {
  final Config _config;
  final darkMode = RxNotifier<bool>(false);

  SettingController(this._config) {
    init();
  }

  void init() {
    darkMode.value = _config.theme.value == 1;
  }

  void changeDarkMode(bool value) {
    darkMode.value = value;
    _config.changeTheme(value == false ? 0 : 1);
  }
}
