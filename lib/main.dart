import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:remember_to_pay/app/app_module.dart';
import 'package:remember_to_pay/app/app_widget.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AndroidAlarmManager.initialize();
  tz.initializeTimeZones();
  await initializeDateFormatting('pt-BR');
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
