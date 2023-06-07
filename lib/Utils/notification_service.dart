import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

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

  Future<void> showBigPictureNotification() async {
    String link =
        "https://static.toiimg.com/thumb/msid-86709670,imgsize-105512,width-400,resizemode-4/86709670.jpg";

    String base64 = await uriToBase64(link);
    BigPictureStyleInformation bigPicInfo = BigPictureStyleInformation(
        ByteArrayAndroidBitmap.fromBase64String(base64));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", "ANDROID",
            styleInformation: bigPicInfo);
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.show(
        1, "Mehul app", "End of Season Sale..", notificationDetails);
  }

  Future<String> uriToBase64(String link) async {
    final http.Response response = await http.get(Uri.parse(link));
    final String base64Data = base64Encode(response.bodyBytes);
    return base64Data;
  }

  Future<void> showFireNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", "ANDROID");

    DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.show(
        1, "$title", "$body", notificationDetails);
  }
}
