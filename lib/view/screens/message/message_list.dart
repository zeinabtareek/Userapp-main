import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/message/widget/admin_messages_page.dart';
import 'package:ride_sharing_user_app/view/screens/message/widget/driver_messages_page.dart';
import 'package:ride_sharing_user_app/view/screens/message/widget/message_item.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/search_widget.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../widgets/custom_tap_bar.dart';
import 'controller/message_controller.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar:   CustomAppBar(title: Strings.ridersAreSayingToYou.tr,showBackButton: true,),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: GetBuilder<MessageController>(builder: (messageController){
    return Column(
            children:  [
              Center(
                child: CustomTapBar(
                  tabController: messageController.tabController,
                  firstTap: Strings.driver.tr,
                  secondTap:Strings.admin.tr,
                ),
              ),
              K.sizedBoxH2,
              const SearchWidget(),
              const SizedBox(height: Dimensions.paddingSizeSmall,),


                Expanded(child: TabBarView(
                controller:messageController. tabController,
                children:  const [
                  AdminMessagesPages(),
                  DriverMessagesPage(),
                ],
              ))
            ],
          );}
          ),
        ),
      ),
    );
  }
}
