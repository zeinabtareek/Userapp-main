import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../util/app_strings.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/text_style.dart';
import '../../widgets/confirmation_dialog.dart';
import '../../widgets/custom_float_action_btn.dart';
import '../chat/controller/chat_controller.dart';
import '../chat/message_screen.dart';
import '../chat/repository/chat_repo.dart';
import '../home/controller/banner_controller.dart';
import '../support/controller/support_controller.dart';
import '../support/support.dart';
import 'bottom_menu_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Get.find<BottomMenuController>().currentTab != 0) {
          Get.find<BottomMenuController>().selectHomePage();
          return false;
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                  icon: Images.profileLogout,
                  description: Strings.doYouWantToExitTheApp.tr,
                  onYesPressed: () {
                    SystemNavigator.pop();
                  },
                );
              });
        }
        return false;
      },
      child: GetBuilder<BottomMenuController>(builder: (menuController) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                PageStorage(
                    bucket: bucket, child: menuController.currentScreen),
                Positioned(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.3),
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: CustomMenuItem(
                                index: 0,
                                name: Strings.home.tr,
                                activeIcon: Images.homeActive,
                                inActiveIcon: Images.homeOutline,
                                currentIndex: menuController.currentTab,
                                tap: () => menuController.selectHomePage()),
                          ),
                          Expanded(
                            child: CustomMenuItem(
                                index: 1,
                                name: Strings.history.tr,
                                activeIcon: Images.activityActive,
                                inActiveIcon: Images.activityOutline,
                                currentIndex: menuController.currentTab,
                                tap: () =>
                                    menuController.selectActivityScreen()),
                          ),
                          Expanded(
                            child: CustomMenuItem(
                                index: 2,
                                name: Strings.notification.tr,
                                activeIcon: Images.notificationActive,
                                inActiveIcon: Images.notificationOutline,
                                currentIndex: menuController.currentTab,
                                tap: () =>
                                    menuController.selectNotificationScreen()),
                          ),
                          Expanded(
                            child: CustomMenuItem(
                                index: 3,
                                name: Strings.profile.tr,
                                activeIcon: Images.profileActive,
                                inActiveIcon: Images.profileOutline,
                                currentIndex: menuController.currentTab,
                                tap: () =>
                                    menuController.selectProfileScreen()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            //
            floatingActionButton: Builder(builder: (context) {
              BannerController bannerController = Get.find<BannerController>();
              bool isLabelVisible;
              return Obx(
                () => Badge(
                  alignment: AlignmentDirectional.topEnd,
                  backgroundColor: Colors.red,
                  isLabelVisible: isLabelVisible =
                      bannerController.unReedCount.value != 0 &&
                          bannerController.unReedCount.value != null,
                  label: Text("${bannerController.unReedCount.value ?? ""}"),
                  child: customFloatActionButton(
                    image: Images.chat,
                    onPressed: () {
                      // if (isLabelVisible) {

                      if (false) {
                        Get.to(
                          () => MessageScreen(
                            chatId: null,
                          ),
                          binding: BindingsBuilder(
                            () {
                              // ignore: avoid_single_cascade_in_expression_statements
                              Get.put(ChatController(chatRepo: ChatRepo()))
                                ..canChat(true)
                                ..setUserTypeIndex(1);
                            },
                          ),
                        );
                      } else {
                        Get.to(() => const HelpAndSupportScreen(),
                            binding: BindingsBuilder(() {
                          // ignore: avoid_single_cascade_in_expression_statements
                          Get.put(SupportController())
                            ..setHelpAndSupportIndex(1);
                        }));
                      }
                    },
                  ),
                ),
              );
            }));
      }),
    );
  }
}

class CustomMenuItem extends StatelessWidget {
  final int index;
  final String name;
  final String activeIcon;
  final String inActiveIcon;
  final int currentIndex;
  final VoidCallback tap;

  const CustomMenuItem(
      {Key? key,
      required this.index,
      required this.name,
      required this.activeIcon,
      required this.inActiveIcon,
      required this.currentIndex,
      required this.tap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: tap,
      child: SizedBox(
        width: currentIndex == index ? 90 : 50,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                currentIndex == index ? activeIcon : inActiveIcon,
                width: Dimensions.menuIconSize,
                height: Dimensions.menuIconSize,
              ),
              if (currentIndex == index)
                Text(
                  name.tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textRegular.copyWith(color: Colors.white),
                )
            ]),
      ),
    );
  }
}
