import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/message/message_list.dart';
import 'package:ride_sharing_user_app/view/screens/message/message_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../chat/controller/chat_controller.dart';
import '../../chat/message_screen.dart';
import '../../chat/repository/chat_repo.dart';
import '../../where_to_go/controller/create_trip_controller.dart';

class ContactWidget extends StatelessWidget {
  ContactWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateATripController>(
      init: CreateATripController(),
      // initState: Get.find<CreateATripController>().showTrip(),
      builder: (controller) => Center(
        child: Container(
          width: 250,
          height: 35,
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall,
              vertical: Dimensions.paddingSizeExtraSmall),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge),
              border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor.withOpacity(.2))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // TODO::  handel  orderId in parcel cicle
                    String orderId = controller.getOrderId()!;

                    Get.to(() => const MessageScreen(),
                        binding: BindingsBuilder(() {
                      // ignore: avoid_single_cascade_in_expression_statements
                      if (Get.isRegistered<ChatController>()) {
                        Get.find<ChatController>()
                          ..initChat()
                          ..toNewChat(orderId);
                      } else {
                        Get.put(ChatController(chatRepo: ChatRepo()))
                          ..initChat()
                          ..toNewChat(orderId);
                      }
                    }));
                  },
                  // onTap: () => Get.to(() => const MessageListScreen()),
                  // onTap: () => Get.to(() => const MessageListScreen()),
                  child: SizedBox(
                      width: Dimensions.iconSizeLarge,
                      child: Image.asset(Images.customerMessage)),
                ),
              ),
              Container(
                  width: 1, height: 25, color: Theme.of(context).primaryColor),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.launchUrlFun(
                    "tel:${controller.orderModel.data?.driver?.phone ?? ''}",
                    false,
                  ),

                  // onTap: () async {
                  //   await launchUrl(launchUri,
                  //       mode: LaunchMode.externalApplication);
                  // },

                  child: SizedBox(
                      width: Dimensions.iconSizeLarge,
                      child: Image.asset(
                        Images.customerCall,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Uri launchUri = Uri(
    scheme: 'tel',
    path: "https://6amtech.com",
  );
}
