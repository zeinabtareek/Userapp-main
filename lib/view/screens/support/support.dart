import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_strings.dart';
import '../../../util/dimensions.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_tap_bar.dart';
import 'widgets/complains_page.dart';
import 'widgets/help_and_support.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int currentPage;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                tabController: tabController,
                firstTap: Strings.helpSupport.tr,
                secondTap: Strings.complains.tr, onTabChanged: (v) {},
              ),
              Expanded(
                  child: TabBarView(
                controller: tabController,
                children: [
                  ContactUsPage(),
                  const ComplainsPage(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
