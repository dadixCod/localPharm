// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// void showNotification() async {
//   var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   var android = AndroidInitializationSettings('@mipmap/ic_launcher');
  
//   var initSettings = InitializationSettings(android: android);
//   flutterLocalNotificationsPlugin.initialize(initSettings);

//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//     'your channel id',
//     'your channel name',
//     importance: Importance.max,
//     priority: Priority.high,
//     ticker: 'ticker',
//   );
 
//   var platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
    
//   );
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'Medication Expiry',
//     'Your medication is expiring soon!',
//     platformChannelSpecifics,
//     payload: 'item x',
//   );
// }
