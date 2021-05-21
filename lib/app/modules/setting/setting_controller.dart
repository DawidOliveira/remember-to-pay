import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:remember_to_pay/app/core/config.dart';
import 'package:remember_to_pay/app/repositories/note/note_repository.dart';
import 'package:rx_notifier/rx_notifier.dart';

class SettingController {
  final Config _config;
  final darkMode = RxNotifier<bool>(false);
  final NoteRepository _noteRepository;
  final Connectivity _connectivity;

  SettingController(this._config, this._noteRepository, this._connectivity) {
    init();
  }

  void init() {
    darkMode.value = _config.theme.value == 1;
  }

  Future<void> syncDB(BuildContext context) async {
    if ((await _connectivity.checkConnectivity()) == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Você está sem conexão com a internet!'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      Modular.to.pop();
      return;
    }
    await _noteRepository.getNotesDBBackup();
    Modular.to.pop();
  }

  void changeDarkMode(bool value) {
    darkMode.value = value;
    _config.changeTheme(value == false ? 0 : 1);
  }
}
