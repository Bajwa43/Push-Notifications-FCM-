import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminSendTheNotificationToUser {
  //This is the user token
  //used to send notification to that user

  String tokenOfReceiver =
      'dCup56V_RUuiwXooo1iukY:APA91bEF619yCs6YANQm_kBbuObcB6m5Orx3AwdRaj6caFjj23pRP_Ojnkz-3ZZwtOSMURMhwYlqV1IK_4ujoufCRoFWmpNinTA68unHKMrOm3HO0WhIfCY6e7oVkNANTJYYHEpcpZz0';

  //

  //

  var serverKey =
      "AAAAFDzSMmA:APA91bEAMc9nC6DtqdZLvW3TP_Ht0WdFgAFDR5hcKZ6iPROXQziXOGqN5YFHz33rj10CSJbaM-y-6GJKtgrYD1fQ0x7bXTDKS01-l4V8BfrGbMRdS8yl5mz3vH5c6KuFQST-_sIv62b_";

  creatingFCMPayload(
      {required String receiverToken,
      String titleOfNotification = "This is the title of Notification",
      String bodyOfNotification = "This is the body of notification"}) {
    tokenOfReceiver = receiverToken;

    return jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': bodyOfNotification,
          'title': titleOfNotification,
        },
        //this data will be utilized by the clint
        //and client can respond by using this data
        'data': <String, dynamic>{
          'name': 'waqas',
          'time': '10 am',
          'service': 'service',
          'status': 'alive',
          'id': 'wwwweedd'
        },
        'to': receiverToken
      },
    );
  }

  Future<bool> sendNotification() async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
          },
          body: creatingFCMPayload(
            receiverToken: tokenOfReceiver,
          ));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}




/**
 * IN Main Class 
 * 
 * Future<void> fun(RemoteMessage message) async {
  print(message.notification!.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(fun);

  runApp(const MyApp());
}
 * 
 * 
 *  ElevatedButton(
              onPressed: () {
                // AdminSidePushNotification notification =
                //     AdminSidePushNotification();
                // notification.sendNotificationToAdmin();
                // SendNotificationToAdmin admin = SendNotificationToAdmin();
                // admin.sendNotificationToAdmin();
                AdminSendTheNotificationToUser adminSendTheNotificationToUser =
                    AdminSendTheNotificationToUser();
                adminSendTheNotificationToUser.creatingFCMPayload(
                    receiverToken:
                        'dCup56V_RUuiwXooo1iukY:APA91bEF619yCs6YANQm_kBbuObcB6m5Orx3AwdRaj6caFjj23pRP_Ojnkz-3ZZwtOSMURMhwYlqV1IK_4ujoufCRoFWmpNinTA68unHKMrOm3HO0WhIfCY6e7oVkNANTJYYHEpcpZz0');
                adminSendTheNotificationToUser.sendNotification();
              },
              child: const Text('send to admin'),
            ),
 * 
 */