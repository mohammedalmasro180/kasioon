import 'package:drive011221/Screens/Home/message.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
//import 'package:notification_permissions/notification_permissions.dart';
class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/ic_flutternotification');
    // Future<PermissionStatus> permissionStatus =
    // NotificationPermissions.getNotificationPermissionStatus();
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,

    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      int id, String title, String body, int seconds
      ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,

      tz.TZDateTime.now(tz.local).add(Duration(seconds:1)),

      const NotificationDetails(


        android: AndroidNotificationDetails(
            'main_channel',
            'Main Channel',
            'Main channel notifications',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@mipmap/ic_launcher'



        ),
        iOS: IOSNotificationDetails(

          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),

      ),
      //payload: screen,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
  Future<void> startdo(int id, String title, String body, int seconds) async {

    var startdo=DateTime.now().add(Duration(seconds: 10));

    await flutterLocalNotificationsPlugin.schedule(6, title, body,startdo,const NotificationDetails(

      android: AndroidNotificationDetails(
          'main_channel',
          'Main Channel',
          'Main channel notifications',
          importance: Importance.max,
          priority: Priority.max,
          icon: '@mipmap/ic_launcher'


      ),
      iOS: IOSNotificationDetails(

        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),

    ),

    );

  }
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}