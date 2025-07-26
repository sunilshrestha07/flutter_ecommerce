import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // Create the instance for the notifications plugin
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Define your Android notification channel info here:
  static const AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
    "default_channel", // Must match ID used in AndroidManifest.xml if you define it there
    "Default Channel",
    description: "Daily notification channel",
    importance: Importance.high,
  );

  // Initialize the notifications plugin
  Future<void> initNotification() async {
    // Android initialization
    const initSettingAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");

    // iOS initialization
    const initSettingIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Initialization settings for both platforms
    const initSetting = InitializationSettings(
      android: initSettingAndroid,
      iOS: initSettingIos,
    );

    // Initialize the plugin
    await notificationsPlugin.initialize(initSetting);

    // Create the Android notification channel (required for Android 8+)
    final androidImpl = notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidImpl?.createNotificationChannel(androidChannel);
  }

  // Notification details helper
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

  // Show a notification with given title and body
  Future<void> showNotification({int id = 0, String? title, String? body}) async {
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }
}
