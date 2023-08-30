import 'package:flutter/material.dart';
import 'package:push_ntoification_between_devices/Second_baseOn_Video/helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final TextEditingController userNameController;
  late TextEditingController titleController;
  late TextEditingController bodyController;
  Helper helper = Helper();

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    titleController = TextEditingController();
    bodyController = TextEditingController();
    // Helper helper = Helper();

    //request Permission
    helper.requestPermission();

    // getToken
    helper.getToken();

    // For notification show in foreground in during open app
    helper.otherInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(hintText: 'UserName'),
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(hintText: 'Body'),
            ),
            ElevatedButton(
                onPressed: () {
                  helper.onBtnClick(
                      userNameController, titleController, bodyController);
                },
                child: const Text('Button'))
          ],
        ),
      ),
    );
  }
}
