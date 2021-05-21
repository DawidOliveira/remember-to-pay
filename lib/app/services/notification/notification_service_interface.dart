abstract class INotificationService {
  Future<void> sendNotification(
      {required String id,
      required String title,
      required String body,
      required DateTime date});
  Future<void> init();
  Future<void> getToken();
  Future<void> listenNotifications();
  Future<void> requestPermissions();
  Future<void> cancelNotification(String id);
  Future<void> cancelAllNotifications();
}
