import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PushNotifcationRequestPermission {
  FirebaseMessaging message = FirebaseMessaging.instance;
  String? token;
// This  is Server key of FireBase CLoud Side
  String serverKey =
      'AAAAFDzSMmA:APA91bEAMc9nC6DtqdZLvW3TP_Ht0WdFgAFDR5hcKZ6iPROXQziXOGqN5YFHz33rj10CSJbaM-y-6GJKtgrYD1fQ0x7bXTDKS01-l4V8BfrGbMRdS8yl5mz3vH5c6KuFQST-_sIv62b_ ';

  String titleOfNotifications = 'First Message';
  String bodyOfNotifications = 'Hey Its Me Fahad!';

  Future<NotificationSettings> request() async {
    var response = message.requestPermission(
        announcement: true,
        badge: true,
        sound: true,
        alert: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false);

    if (kDebugMode) {
      // print('Request Granted : ${response.authorizationStatus}');
      print('Permission is Granted.....');
    }
    return response;
  }

// This method for get token from current device in which app is working
  Future<String?> getTokenRegisterApp() async {
    token = await message.getToken();

    print('Token :$token');
    return token;
  }

  String get body {
    return jsonEncode(<String, dynamic>{
      'to':
          'd3oWeEvSTXSwUwDC7qeYZ_:APA91bHDvbBcaccoo5eHkKpQq_JBooSgjd9q8zFlPYUQyeCcDFSID8C_LU7IlOfH8geOHfH1fsNF_yve4QJyFpJd7hrMR5SFkJGhjEqeexRFJfRLjg-ZuCn20P3Nvisgrv4Htr4qHN4_',
      "notification": <String, dynamic>{
        "body": "Body of Your Notification",
        "title": "Title of Your Notification"
      },
      "data": <String, dynamic>{
        "body": "Notification Body",
        "title": "Notification Title",
        "key_1": "Value for key_1",
        "key_2": "Value for key_2"
      }
    });
  }

// This Method for the send on server storage at this Post(Url) location
// your all Data from Admin Side .In This Header ServerKey of Firabase Cloud Messaging lagecy for Authentication.
// In Body at 'to' key we send The Next Clint side Device Token by this Token server decide which device
// match this token then sent to that device.
// Other ALL Are Message for Clint (:-
  Future<bool> sendNotificationToClintFromAdmin() async {
    print('.................................');
    try {
      var res =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization': 'key=$serverKey',
              },
              body: body);
      print('......Sucess..........$res');
      print(res.body);
      print(res.statusCode);
      return true;
    } catch (e) {
      print('----->>$e');
      return false;
    }
  }
}


/**
 * Infinix
 * eNKsV3mwRse3TJ_Y55St2m:APA91bHPJ9oAQCKDKvhizs_2WwJuG7epZViEel2VAZufN3LLQ-NDsUYtfaVcRZ7lEXKJjY0DeXXvmg04tvm_zecfwAzHt7jp6FQiNIDqmRIZecAwMlc4iKtzqYdgqExvLXDvXfFSkg34  
 * 
 * Oppo
 * dcnn-82yTuC-yMext3cjBo:APA91bEuW-imoZs0nx2YG9FGCePhBsNRxdKLDc9xKgb8GjSc1BS98mf6fV3UJU5ZfOdxjaxi7ENreUYVWdgaRb6VFCq1zgFDRvmlf6Xom_63sh7C1xIJ-7Pv21fmrWahr-KvUl19AT0G
 * 
 */ 