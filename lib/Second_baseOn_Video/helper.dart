import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:push_ntoification_between_devices/NotificationClickScreen.dart';

class Helper {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

// Request Permission
  void requestPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
//  Auturize the Request From Device is Granted or not For Check
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted the Permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted the provisional permisssion');
    } else {
      log('User Decline the permission and has no Accept permission');
    }
  }

  // get token From Curent Device by this Method
  getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      saveToken(token);

      log('Token is :> $token');
    });
  }

//  Save Token to FireStore On base of Doc() change .
//  At Every New Device Token We Change Just Doc Mean User 1,2,3,4 etc
  saveToken(String? token) async {
    await FirebaseFirestore.instance
        .collection('UserTokens')
        .doc('User2')
        .set({'Token': token}, SetOptions(merge: true)).then(
            (value) => log('token is Saved :..............'));
  }

// Other Info Methods ...............................................................
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  otherInfo(BuildContext context) {
    var androidInitialized =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // var IosInitializd = IOSInitializationSettings();

    var initializedSetting =
        InitializationSettings(android: androidInitialized);

// this is for at Notification click What happen mean Which Screen
// Will Open At respond on click on notification.
    flutterLocalNotificationsPlugin.initialize(
      initializedSetting,
      onDidReceiveNotificationResponse: (response) {
        try {
          if (response.payload != null && response.payload!.isNotEmpty) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return NotificationClickScreen(
                    info: response.payload.toString());
              },
            ));
          } else {}
        } catch (e) {
          log('$e');
        }
      },
    );

// This Method deal for recieve any type of messsage from firebase ...........................

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('...................$message........................');
      log('Message ..: ${message.notification!.title}/${message.notification!.body}}');

      // I think for Text ArrangeMent And Style
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.title.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.body.toString(),
        htmlFormatContentTitle: true,
      );
      // This Important ,Android Details
      AndroidNotificationDetails? androidPlatformChannelspecific =
          AndroidNotificationDetails('43', 'Bajwa Channnel',
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              // playSound: true,
              priority: Priority.high,
              color: Colors.amber);

      NotificationDetails plateformChannelSpecefic =
          NotificationDetails(android: androidPlatformChannelspecific);
//  this method for show the notification on  device
      await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
          message.notification!.body, plateformChannelSpecefic,
          payload: message.data['body']);
    });
  }

//............................................................................

  // Body In JsonEncode format
  createdFCMPayload(
      {required String token,
      String title = 'Notification',
      String body = 'Its My First Notification'}) {
    return jsonEncode({
      'notification': {
        'title': title,
        'body': body,
        'android_channel_id': '43'
      },
      'priority': 'high',
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK ',
        'status': 'alive',
        // 'title': title,
        'body': body,
      },
      'to': token
    });
  }

  // Send Push Notification Method
  String serverKey =
      'AAAAFDzSMmA:APA91bEAMc9nC6DtqdZLvW3TP_Ht0WdFgAFDR5hcKZ6iPROXQziXOGqN5YFHz33rj10CSJbaM-y-6GJKtgrYD1fQ0x7bXTDKS01-l4V8BfrGbMRdS8yl5mz3vH5c6KuFQST-_sIv62b_';

  sendPushNotification(
      {required String token,
      String title = 'Notification',
      String body = 'Its My First Notification'}) async {
    try {
      var res = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Key=$serverKey'
        },
        body: createdFCMPayload(token: token, title: title, body: body),
      );
      log('${res.statusCode}');
    } catch (e) {
      if (kDebugMode) {
        print('...xx..Error Push Notification......');
      }
    }
  }

  // Method  Click On Btn
  onBtnClick(
    TextEditingController userNameController,
    TextEditingController titleController,
    TextEditingController bodyController,
  ) async {
    log('...........BtnClick...............');
    String name = userNameController.text;
    String titile = titleController.text;
    String body = bodyController.text;
    log('name : $name , tittle: $titile,  body : $body');

    if (name.isNotEmpty) {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('UserTokens')
          .doc(name)
          .get();
      String token = snap['Token'];
      log('New Token : $token');

      sendPushNotification(token: token, title: titile, body: body);
    }
  }
}
