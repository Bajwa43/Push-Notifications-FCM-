import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotSuccessFull extends StatefulWidget {
  const NotSuccessFull({super.key});

  @override
  State<NotSuccessFull> createState() => _NotSuccessFullState();
}

class _NotSuccessFullState extends State<NotSuccessFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Notification Not SuccessFully Recieve'),
          centerTitle: true),
      body: const Center(child: Text('Not WellCome')),
    );
  }
}
