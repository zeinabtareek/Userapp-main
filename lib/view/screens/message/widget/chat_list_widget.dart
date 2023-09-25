


import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../util/dimensions.dart';
import '../controller/message_controller.dart';
import 'message_bubble.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(builder: (messageController) {
      return SingleChildScrollView(
        child: Wrap(
          children: [
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              //itemCount: messageController.conversationList.length,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 15,
              reverse: true,
              itemBuilder: (context, index) {
                return ConversationBubble(
                  isRightMessage: Random().nextBool(),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}