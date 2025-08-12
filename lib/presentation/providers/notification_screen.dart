import 'package:edumate/state/notifications/notification_badge.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:edumate/helpers/push_notification.dart';
import 'package:overlay_support/overlay_support.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //initiate firebase messaging
  late final FirebaseMessaging _messaging;
  late int _totalNotificationCounter;

  // model
  PushNotification? _notificationInfo;

  void registerNotification() async {
    // instance of firebase messaging
    _messaging = FirebaseMessaging.instance;
    // three types of state in notification
    // not determined (null), granted (true) and declined (false)
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted the permission");

      // main message
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );
        setState(() {
          _totalNotificationCounter++;
          _notificationInfo = notification;
        });

        showSimpleNotification(
          Text(notification.dataTitle ?? notification.title!),
          subtitle: Text(notification.dataBody ?? notification.body!),
          background: Colors.blue,
          leading:
              NotificationBadge(totalNotification: _totalNotificationCounter),
        );
            });
    } else {
      print("User declined or has not accepted the permission");
    }
  }

  checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification!.title,
        body: initialMessage.notification!.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );
      setState(() {
        _totalNotificationCounter++;
        _notificationInfo = notification;
      });
    }
  }

  @override
  void initState() {
    // when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
      setState(() {
        _totalNotificationCounter++;
        _notificationInfo = notification;
      });
    });
    // normal notification
    registerNotification();
    _totalNotificationCounter = 0;
    //when app is in terminated state
    checkForInitialMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("wwwww"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "FlutterPushNotification",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 12,
            ),

            // show a notification badge that will count th total notifocation that  we receive
            NotificationBadge(totalNotification: _totalNotificationCounter),
            const SizedBox(
              height: 12,
            ),
            //if notificationInfo is not null
            _notificationInfo != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "BODY: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
