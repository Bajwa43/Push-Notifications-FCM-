import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:push_ntoification_between_devices/Appointments_ModelClass/Appointmnets.dart';

class HelperForPushNotification {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static const String serverKey =
      'AAAAFDzSMmA:APA91bEAMc9nC6DtqdZLvW3TP_Ht0WdFgAFDR5hcKZ6iPROXQziXOGqN5YFHz33rj10CSJbaM-y-6GJKtgrYD1fQ0x7bXTDKS01-l4V8BfrGbMRdS8yl5mz3vH5c6KuFQST-_sIv62b_ ';

  static String? getToken() {
    _firebaseMessaging.getToken().then((token) => print('Token : -->> $token'));
  }
}






// Future<void> fun(RemoteMessage message) async {
//   print(message.notification!.body);
// }

// class HelperPushNotifications {
//   FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//   FirebaseFirestore db = FirebaseFirestore.instance;

//   // void initCloud() async {
//   //   FirebaseMessaging.onBackgroundMessage();
//   // }

//   tokenStoreInFirestore({required String docFieldName}) async {
//     await firebaseMessaging.getToken().then((token) {
//       db.collection('appointments').doc('tokens').update({docFieldName: token});
//       print('Token:  $token');
//     });
//   }





//.....................................................................................................
  // Future<void> setUpInteractiveMessage(BuildContext context) async {
  //   FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await firebaseMessaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   log('User granted permission: ${settings.authorizationStatus}');

  //   RemoteMessage? initialMessage = await firebaseMessaging.getInitialMessage();

  //   if (initialMessage != null) {
  //     return _mapMessagetoUser(initialMessage);
  //   }

  //   FirebaseMessaging.onMessageOpenedApp.listen(_mapMessagetoUser);
  // }
// }

// it work as a first time set and next time update at same Key in {};...................................<<<<
// set({},SetOptions(merge: true))

// void _mapMessagetoUser(
//   RemoteMessage message,
// ) {
//   Map<String, dynamic> json = message.data;

//   if (message.data['service'] != null) {
//     Appointments appt = Appointments(
//         name: json['name'],
//         id: json['id'],
//         service: json['service'],
//         status: json['status'],
//         time: DateTime.parse(json['time']));
//     // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const  SuccessScreen(),));
//     print('------> Navigator Successfully ');
//   } else {
//     // Navigator.push(context,
//     //     MaterialPageRoute(builder: (context) => const NotSuccessFull()));
//     print('------> Not Navigator Successfully ');
//   }
// }
