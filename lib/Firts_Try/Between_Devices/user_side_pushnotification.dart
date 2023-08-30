import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'Helper_PushNotification.dart';
import 'admin_side_pushnotification.dart';

class SendPushNotificationFromAdminToUser {
  createdFCMPayload(
      {String? title = 'My First title From Admin',
      String? body = 'My First Body From Admin'}) {
    return jsonEncode({
      'notification': {
        'title': title,
        'body': body,
      },
      'data': {
        'name': 'hi',
        'service': 'Need Gestrology Chackup ',
        'id': '1',
      },
      'to':
          "frGjFm1NSg6E1k0u_Hv0gR:APA91bGYeBDfQIoi-rMmO8CTZMvFEtGp-qRdtbteTjAyStO2tz8_gas91kUDLlMpolIX70asuvAlsOjcTlPGvVxGhH-nGF6dz03yWn3CZoFt06YcUBl9V7N8y8Skiy6z6IN38-hw2EcN"
    });
  }

  sendNotficationToUser({String? title, String? body}) async {
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

// class UserSidePushNotification {
//   String token = '';
//   String serverKey =
//       'AAAAFDzSMmA:APA91bEAMc9nC6DtqdZLvW3TP_Ht0WdFgAFDR5hcKZ6iPROXQziXOGqN5YFHz33rj10CSJbaM-y-6GJKtgrYD1fQ0x7bXTDKS01-l4V8BfrGbMRdS8yl5mz3vH5c6KuFQST-_sIv62b_ ';

//   String get body {
//     return jsonEncode({
//       'notification': {
//         'body':
//             "Hi ${appointments.name}, Your ${appointments.service} appointment has been confirmed!",
//         'title': "Appointment Confirmed",
//       },
//       'data': {
//         'name': appointments.name,
//       },
//       'to': token,
//     });
//   }

//   sendNotificationToUser() async {
//     await FirebaseFirestore.instance
//         .collection('appointments')
//         .doc('tokens')
//         .get()
//         .then((snapshot) {
//       token = snapshot['user-token'];
//     });

//     if (token.isEmpty) {
//       return log('Unable to send FCM message, no token exists.');
//     }

//     try {
//       await http.post(
//         Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authentication': 'key=$serverKey'
//         },
//         body: body,
//       );
//       print(
//           '..................................................${body}................');
//     } catch (e) {
//       print('Error Push Notificstion -> : $e');
//     }
//   }
// }
