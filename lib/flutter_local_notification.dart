import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;


class Local_notification {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init()async{
       await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification:(id, title, body, payload) => null,);

final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse:(details) => null);
        requestExactAlarmPermission();

  }
 

 static Future scheduleNotification({
  required String title,
  required String body,
  required String payload,
  required int id,
  required int hour,
  required int minute,
}) async {

tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  await _flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime.now(tz.local).add(const Duration(days: 1)).subtract(Duration(hours: tz.TZDateTime.now(tz.local).hour, minutes: tz.TZDateTime.now(tz.local).minute, seconds: tz.TZDateTime.now(tz.local).second)).add(Duration(hours: hour, minutes: minute)),
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
  /*
  await _flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'scheduled title',
    'scheduled body',
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    const NotificationDetails(
        android: AndroidNotificationDetails(
            'your channel id', 'your channel name',
            channelDescription: 'your channel description')),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);*/
}


  
  static Future showPeriodicNotification({
    required String title,
    required String body,
    required String payload,
    required int id,
  })async
  {
     const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel 2', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
        const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(id, title, body, RepeatInterval.daily, notificationDetails);

  }
  static Future cancel(int id) async{
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
  static Future showNotification({
    required String title,
    required String body,
    required String payload,
  })async{

    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel 1', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
await _flutterLocalNotificationsPlugin.show(
    0,title, body, notificationDetails,
    payload: payload);
  }
  
}

void requestExactAlarmPermission() async {
  if (await Permission.scheduleExactAlarm.request().isGranted) {
    // Either the permission was already granted before or the user just granted it.
    print("Exact alarm permission granted");
  } else {
    print("Exact alarm permission not granted");
  }
}