import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ride_sharing_user_app/authenticate/presentation/controller/auth_controller.dart';

import '../../../../authenticate/domain/use-cases/auth_cases.dart';
import '../../../../initialize_dependencies.dart';
import '../../../../localization/localization_controller.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/confirmation_dialog.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../../../widgets/custom_image.dart';
import '../../chat/chat_screen.dart';
import '../../history/history_screen.dart';
import '../../offer/offer_screen.dart';
import '../../settings/screen/setting_screen.dart';
import '../../support/controller/support_controller.dart';
import '../../support/support.dart';
import '../../wallet/wallet_screen.dart';
import '../edit_profile_screen/edit_profile_screen.dart';
import '../widgets/profile_item.dart';
import 'controller/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progressValue = 0.7;
    return Scaffold(
      body: GetBuilder<UserController>(builder: (controller) {
        return CustomBody(
          appBar: CustomAppBar(
            title: Strings.makeYourProfileToEarnPoint.tr,
            showBackButton: false,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 140,
                          width: 280,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Row(children: [
                                      //   // Text(
                                      //   //     "${Strings.level.tr} : ${userController.userModel?.userLevelModel?.currentLevel}",
                                      //   //     style: textBold.copyWith(
                                      //   //         color:
                                      //   //             Theme.of(context).hintColor,
                                      //   //         fontSize:
                                      //   //             Dimensions.fontSizeSmall)),
                                      //   const SizedBox(
                                      //     width: 5,
                                      //   ),
                                      //   // Image.asset(
                                      //   //   userController
                                      //   //               .userModel
                                      //   //               ?.userLevelModel
                                      //   //               ?.currentLevel ==
                                      //   //           "1"
                                      //   //       ? Images.level1
                                      //   //       : userController
                                      //   //                   .userModel
                                      //   //                   ?.userLevelModel
                                      //   //                   ?.currentLevel ==
                                      //   //               "2"
                                      //   //           ? Images.level2
                                      //   //           : userController
                                      //   //                       .userModel
                                      //   //                       ?.userLevelModel
                                      //   //                       ?.currentLevel ==
                                      //   //                   "3"
                                      //   //               ? Images.level3
                                      //   //               : userController
                                      //   //                           .userModel
                                      //   //                           ?.userLevelModel
                                      //   //                           ?.currentLevel ==
                                      //   //                       "4"
                                      //   //                   ? Images.level4
                                      //   //                   : Images.level5,
                                      //   //   width: Dimensions.iconSizeMedium,
                                      //   // )
                                      // ]),
                                      Row(
                                        children: [
                                          Text(
                                            '${Strings.yourRating.tr} :'.tr,
                                            style: K.hintSmallTextStyle,
                                          ),
                                          const SizedBox(
                                            height: Dimensions
                                                .paddingSizeExtraSmall,
                                          ),
                                          Text(
                                            "${controller.user?.rating?.toString()}",
                                            style: K.hintSmallTextStyle,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            size: 12,
                                            color: Colors.amber,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  CircularPercentIndicator(
                                    radius: 20.0,
                                    lineWidth: 2.5,
                                    percent:  (double.tryParse(controller.user?.profileCompletedRatio.toString() ?? '0.0') ?? 0.0) / 100,
                                    backgroundColor: Colors.white,
                                    center: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: FittedBox(
                                        child: Text("${(controller.user?.profileCompletedRatio ?? 0.0).toStringAsFixed(0)}%",
                                          style: textMedium.copyWith(
                                              fontSize: 10,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    ),
                                    progressColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildColumnItem(
                                      Strings.totalRide,
                                      controller.user?.ridesCount ?? "",
                                      context),
                                  Container(
                                    width: 1,
                                    height: 40,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  // _buildColumnItem(
                                  //     Strings.totalPoint, '242', context)
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: -40,
                          left: Get.find<LocalizationController>().isLtr
                              ? -25
                              : null,
                          right: Get.find<LocalizationController>().isLtr
                              ? null
                              : -25,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CustomImage(
                                height: 80,
                                width: 80,
                                image: controller.user?.img ?? "",
                                placeholder: Images.personPlaceholder,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -30,
                          left:
                              Get.find<LocalizationController>().isLtr ? 65 : 0,
                          right:
                              Get.find<LocalizationController>().isLtr ? 0 : 65,
                          child: SizedBox(
                            width: 210,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    controller.user?.viewName ?? "",
                                    style: textBold.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeExtraLarge),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ProfileMenuItem(
                    title: Strings.profile.tr,
                    icon: Images.profileProfile,
                    onTap: () => Get.to(() => const EditProfileScreen(),
                        binding: BindingsBuilder(() {
                      controller.onInit();
                    })),
                  ),
                  ProfileMenuItem(
                      title: Strings.myOffer.tr,
                      icon: Images.profileMyOrder,
                      onTap: () => Get.to(() => const OfferScreen())),
                  ProfileMenuItem(
                    title: Strings.message.tr,
                    icon: Images.profileMessage,
                    onTap: () => Get.to(() => const ChatScreen()),
                  ),
                  ProfileMenuItem(
                    title: Strings.myWallet,
                    icon: Images.profileMyWallet,
                    onTap: () => Get.to(() => const WalletScreen()),
                  ),
                  ProfileMenuItem(
                    title: Strings.myTrips.tr,
                    icon: Images.profileMyTrip,
                    onTap: () => Get.to(() => const HistoryScreen(
                          fromPage: Strings.profile,
                        )),
                  ),
                  ProfileMenuItem(
                    title: Strings.helpSupport.tr,
                    icon: Images.profileHelpSupport,
                    onTap: () => Get.to(() => const HelpAndSupportScreen(),binding: BindingsBuilder(() {
                      // ignore: avoid_single_cascade_in_expression_statements
                      Get.put(SupportController())..setHelpAndSupportIndex(1);
                    })),
                  ),
                  ProfileMenuItem(
                    title: Strings.settings.tr,
                    icon: Images.profileSetting,
                    onTap: () => Get.to(() => const SettingScreen()),
                  ),
                  GetBuilder<AuthController>(
                    init: AuthController(sl()),
                    autoRemove: false,
                    builder: (controller) {
                      return ProfileMenuItem(
                        title: Strings.logout.tr,
                        icon: Images.profileLogout,
                        divider: false,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return ConfirmationDialog(
                                  icon: Images.profileLogout,
                                  title: Strings.logout.tr,
                                  description:
                                      Strings.doYouWantToLogOutThisAccount.tr,
                                  onYesPressed: () async {
                                    if (await sl<AuthCases>()
                                        .isAuthenticated()) {
                                      await controller.logOut();
                                      controller.initLoginWithPassScreen();
                                      await sl<AuthCases>().setUserDate(null);
                                    }
                                  },
                                );
                              });
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraLarge * 4,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Column _buildColumnItem(String title, String value, BuildContext context) =>
      Column(
        children: [
          Text(
            value,
            style: textBold.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: Dimensions.fontSizeExtraLarge),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeExtraSmall,
          ),
          Text(title.tr,
              style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
        ],
      );
}
