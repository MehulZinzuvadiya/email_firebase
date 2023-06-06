import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static NotificationService notificationService = NotificationService._();

  NotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('appicon');

    final DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidSettings, iOS: iosSettings, macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showSimpleNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", "ANDROID");
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.show(
        1, "Mehul App", "Simple Notification", notificationDetails);
  }

  Future<void> zonedSchedule() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", "ANDROID");
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        12345,
        "A Notification From My App",
        "This notification is brought to you by Local Notifcations Package",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 2)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> showNotificationWithSound() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", "ANDROID",
            sound: RawResourceAndroidNotificationSound('pikachu'),
        playSound: true);
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.show(
        1, "Flutter Notification", "Sound Notification", notificationDetails);
  }
}
