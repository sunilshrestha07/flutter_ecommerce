import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // Singleton instance
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
    "default_channel",
    "Default Channel",
    description: "Daily notification channel",
    importance: Importance.high,
  );

  bool _isInitialized = false;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    const initSettingAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");

    const initSettingIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSetting = InitializationSettings(
      android: initSettingAndroid,
      iOS: initSettingIos,
    );

    await notificationsPlugin.initialize(initSetting);

    final androidImpl = notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidImpl?.createNotificationChannel(androidChannel);

    _isInitialized = true; // Mark as initialized
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "default_channel",
        "Default Channel",
        channelDescription: "Daily notification channel",
        priority: Priority.high,
        importance: Importance.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({int id = 0, String? title, String? body}) async {
    await notificationsPlugin.show(id, title, body, notificationDetails());
  }
}
