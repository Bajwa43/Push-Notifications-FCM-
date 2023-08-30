import 'package:flutter/material.dart';

class NotificationClickScreen extends StatelessWidget {
  const NotificationClickScreen({required this.info, super.key});
  final String info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigated Screen'),
      ),
      body: Center(
          child: Text(
        info,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: Colors.blueAccent),
      )),
    );
  }
}
