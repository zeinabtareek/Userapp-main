
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'message_item.dart';

class DriverMessagesPage extends StatelessWidget {
  const DriverMessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index){
      return  MessageItem(
        isRead: Random().nextBool(),
      );
    },
      itemCount: 10,
      padding: const EdgeInsets.all(0),
    );
  }
}
