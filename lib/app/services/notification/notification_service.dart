import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
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

  final FirebaseMessaging _fm;

  final id = RxNotifier<int>(0);
  final title = RxNotifier<String>('title');
  final body = RxNotifier<String>('body');
  final token = RxNotifier<String?>('');

  void setId(int value) => id.value = value;
  void setTitle(String value) => title.value = value;
  void setBody(String value) => body.value = value;

  void setInfoNotification(int id, String title, String body) {
    setId(id);
    setTitle(title);
    setBody(body);
  }

  NotificationService(this._fm) {
    init();
  }

  Future<void> init() async {
    await requestPermissions();
    await getToken();
    await listenNotifications();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                androidPlatformChannelSpecifics.channelId,
                androidPlatformChannelSpecifics.channelName,
                androidPlatformChannelSpecifics.channelDescription,
              ),
            ));
      }
    });
  }

  Future<void> sendNotification(
      {required String id,
      required String title,
      required String body,
      required DateTime date}) async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();

    final location = tz.getLocation(currentTimeZone);

    await flutterLocalNotificationsPlugin
        .zonedSchedule(
      id.hashCode,
      title,
      body,
      tz.TZDateTime.from(date, location),
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidPlatformChannelSpecifics.channelId,
          androidPlatformChannelSpecifics.channelName,
          androidPlatformChannelSpecifics.channelDescription,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    )
        .then((_) async {
      await Future.delayed(Duration(hours: 14));
      await cancelNotification(id);
      final newDate = DateTime(
          date.day == 31 &&
                  date.month == 12 &&
                  date.hour == 23 &&
                  date.minute == 59
              ? date.year + 1
              : date.year,
          date.month == 12 ? 1 : date.month + 1,
          date.day,
          date.hour,
          date.minute,
          date.second);
      await sendNotification(id: id, title: title, body: body, date: newDate);
    });
  }

  Future<void> cancelNotification(String id) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(id.hashCode);
    } catch (e) {
      print('cancelNotification: $e');
    }
  }

  Future<void> requestPermissions() async {
    NotificationSettings settings = await _fm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> getToken() async {
    token.value = await _fm.getToken();
  }

  Future<void> listenNotifications() async {
    FirebaseMessaging.onMessage.listen((event) {
      print(event.data);
    });
  }
}
