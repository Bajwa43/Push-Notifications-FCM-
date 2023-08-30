import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_ntoification_between_devices/Second_baseOn_Video/main_screen.dart';
// import 'package:push_ntoification_between_devices/Between_Devices/Helper_PushNotification.dart';
// import 'package:push_ntoification_between_devices/Between_Devices/admin_side_pushnotification.dart';
// import 'package:push_ntoification_between_devices/Between_Devices/user_side_pushnotification.dart';
// import 'package:push_ntoification_between_devices/one_way_PushNotification/push_notification_request_permission.dart';

Future<void> fun(RemoteMessage message) async {
  print(message.notification!.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // App is conneced/ initialzie with firebase
  await Firebase.initializeApp();
  // For notification on background
  FirebaseMessaging.instance.getInitialMessage();
  // FirebaseMessaging.onBackgroundMessage(fun);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  // PushNotifcationRequestPermission helper = PushNotifcationRequestPermission();

  // void _incrementCounter() {
  //   print('Before Register');
  //   helper.getTokenRegisterApp();

  //   // print('Before Requets');
  //   // helper.request();

  //   print('After Register');
  //   helper.sendNotificationToClintFromAdmin();
  // }

  @override
  void initState() {
    super.initState();

    // HelperPushNotifications _helperPushNotifications =
    //     HelperPushNotifications();

    // _helperPushNotifications.setUpInteractiveMessage(context);
    // _helperPushNotifications.tokenStoreInFirestore(docFieldName: 'admin-token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      floatingActionButton: ButtonBar(
        children: [
          ElevatedButton(onPressed: () {}, child: const Text('Send to Admin')),
          ElevatedButton(onPressed: () {}, child: const Text('Send to User')),
        ],
      ),
      // // floatingActionButton: ButtonBar(
      // //   children: [
      // //     ElevatedButton(
      // //       onPressed: () {
      // //         AdminSidePushNotification notification =
      // //             AdminSidePushNotification();
      // //         notification.sendNotificationToAdmin();
      // //       },
      // //       child: const Text('send to admin'),
      // //     ),
      // //     ElevatedButton(
      // //       onPressed: () {
      // //         UserSidePushNotification notification =
      // //             UserSidePushNotification();
      // //         notification.sendNotificationToUser();
      // //       },
      // //       child: const Text('Send to user'),
      // //     ),
      //   ],
      // )
    );
  }
}
