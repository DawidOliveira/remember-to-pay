import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config extends Disposable {
  SharedPreferences? _ps;
  final theme = RxNotifier<int>(0);

  Config() {
    init();
  }

  Future<void> init() async {
    _ps = await SharedPreferences.getInstance();
    if (_ps!.getInt('theme') == null) {
      changeTheme(0);
      return;
    }
    theme.value = _ps!.getInt('theme') ?? 0;
  }

  void changeTheme(int value) async {
    await _ps!.setInt("theme", value);
    theme.value = _ps!.getInt('theme')!;
  }

  @override
  void dispose() {}
}
