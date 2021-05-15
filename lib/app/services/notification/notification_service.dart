import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rx_notifier/rx_notifier.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final id = RxNotifier<int>(0);
  final title = RxNotifier<String>('title');
  final body = RxNotifier<String>('body');

  void setId(int value) => id.value = value;
  void setTitle(String value) => title.value = value;
  void setBody(String value) => body.value = value;

  void setInfoNotification(int id, String title, String body) {
    setId(id);
    setTitle(title);
    setBody(body);
  }

  Future<void> requestPermissions() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        return '';
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        return '';
      },
    );
  }

  static Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'note',
      'Note Remember',
      'note remember',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      enableVibration: true,
      enableLights: true,
      visibility: NotificationVisibility.public,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await NotificationService().flutterLocalNotificationsPlugin.show(
          0,
          'Olá rsrs',
          'Você tem conta para pagar hoje, ta bom?!',
          platformChannelSpecifics,
        );
  }

  Future<void> sendNotification(String id, DateTime date) async {
    await AndroidAlarmManager.periodic(
      Duration(days: 30),
      id.hashCode,
      showNotification,
      exact: true,
      startAt: date,
    ).then((value) => print(value));
  }

  Future<void> cancelNotification(String id) async {
    await AndroidAlarmManager.cancel(id.hashCode).then((value) => print(value));
  }
}
