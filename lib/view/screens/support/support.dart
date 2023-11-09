import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_strings.dart';
import '../../../util/dimensions.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_tap_bar.dart';
import 'controller/support_controller.dart';
import 'widgets/complains_page.dart';
import 'widgets/help_and_support.dart';

class HelpAndSupportScreen extends GetView<SupportController> {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBody(
        appBar: CustomAppBar(
          title: Strings.doYouNeedHelp.tr,
          centerTitle: true,
          showBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Column(
            children: [
              CustomTapBar(
                tabController: controller.tabController,
                firstTap: Strings.helpSupport.tr,
                secondTap: Strings.complains.tr,
                onTabChanged: controller.setHelpAndSupportIndex,
              ),
              Expanded(child: GetBuilder<SupportController>(
                builder: (_) {
                  return TabBarView(
                    controller: controller.tabController,
                    children: [
                      ContactUsPage(),
                      const ComplainsPage(),
                    ],
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
