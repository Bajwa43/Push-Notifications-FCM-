import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
// import 'package:push_ntoification_between_devices/Appointments_ModelClass/Appointmnets.dart';
// import 'package:push_ntoification_between_devices/Between_Devices/Helper_PushNotification.dart';

import 'Helper_PushNotification.dart';

class SendNotificationFromUserToAdmin {
  String createdFCMPayload({
    String? title = 'My First title From User',
    String? body = 'My First Body From User',
  }) {
    return jsonEncode({
      'notification': {
        'title': title,
        'body': body,
      },
      'data': {
        'name': 'Fahad',
        'service': 'Need Gestrology Chackup ',
        'id': '1',
      },
      'to':
          "dCup56V_RUuiwXooo1iukY:APA91bEF619yCs6YANQm_kBbuObcB6m5Orx3AwdRaj6caFjj23pRP_Ojnkz-3ZZwtOSMURMhwYlqV1IK_4ujoufCRoFWmpNinTA68unHKMrOm3HO0WhIfCY6e7oVkNANTJYYHEpcpZz0"
    });
  }

  sendNotficationToAdmin({String? title, String? body}) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            'Content-Type': 'application/json',
            'Authentication': 'key=${HelperForPushNotification.serverKey}'
          },
          body: createdFCMPayload(title: title, body: body));

      print('..................>> : $createdFCMPayload()');
    } catch (e) {
      print('...........$createdFCMPayload()');
      print('Error is :>>> $e');
    }
  }
}

// Appointments appointments = Appointments(
//     name: 'Fahad',
//     id: 6.toString(),
//     service: 'Gestarology Chackup',
//     status: '2 Year Old Problem',
//     time: DateTime.now());

// class AdminSidePushNotification {
//   String token = '';
//   String serverKey =
//       'AAAAFDzSMmA:APA91bEAMc9nC6DtqdZLvW3TP_Ht0WdFgAFDR5hcKZ6iPROXQziXOGqN5YFHz33rj10CSJbaM-y-6GJKtgrYD1fQ0x7bXTDKS01-l4V8BfrGbMRdS8yl5mz3vH5c6KuFQST-_sIv62b_';

//   String get body {
//     return jsonEncode(<String, dynamic>{
//       'notification': <String, dynamic>{
//         'title': 'Appointments',
//         'body': 'I need Chackup So I need this Appointmnets'
//       },
//       'data': <String, dynamic>{
//         'name': appointments.name,
//         'service': appointments.service,
//         'status': appointments.status,
//         'id': appointments.id,
//         'time': appointments.time.toString(),
//       },
//       'to': token,
//     });
//   }

//   sendNotificationToAdmin() async {
//     await FirebaseFirestore.instance
//         .collection('appointments')
//         .doc('tokens')
//         .get()
//         .then((snapshot) {
//       token = snapshot['admin-token'];
//     });

//     await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authentication': 'key=$serverKey'
//       },
//       body: body,
//     );
//   }
// }
