import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_tap_bar.dart';
import 'controller/message_controller.dart';
import 'widget/admin_messages_page.dart';
import 'widget/driver_messages_page.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(
          title: Strings.ridersAreSayingToYou.tr,
          showBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: GetBuilder<MessageController>(builder: (messageController) {
            return Column(
              children: [
                Center(
                  child: CustomTapBar(
                    tabController: messageController.tabController,
                    firstTap: Strings.driver.tr,
                    secondTap: Strings.admin.tr, onTabChanged: (v) {},
                  ),
                ),
                K.sizedBoxH2,
                // const SearchWidget(),
                // K.sizedBoxH0,
                Expanded(
                    child: TabBarView(
                  controller: messageController.tabController,
                  children: const [
                    AdminMessagesPages(),
                    DriverMessagesPage(),
                  ],
                ))
              ],
            );
          }),
        ),
      ),
    );
  }
}
