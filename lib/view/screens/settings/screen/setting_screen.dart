import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../authenticate/config/config.dart';
import '../../../../authenticate/domain/use-cases/auth_cases.dart';
import '../../../../authenticate/presentation/controller/auth_controller.dart';
import '../../../../authenticate/presentation/reset-password-screen/reset_password_screen.dart';
import '../../../../initialize_dependencies.dart';
import '../../../../theme/theme_controller.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/confirmation_dialog.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../../../widgets/custom_button.dart';
import '../controller/settings_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) {
        return Scaffold(
          body: CustomBody(
            appBar: CustomAppBar(
              title: 'settings'.tr,
              showBackButton: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'notification_sound'.tr,
                      style: textRegular.copyWith(),
                    ),
                    leading: Icon(
                      Icons.notifications_sharp,
                      color: Theme.of(context).primaryColor,
                    ),
                    trailing: Obx(() => GestureDetector(
                          onTap: () {
                            controller.isUpdateMode(true);
                            controller.isActiveNonfiction(
                                !controller.isActiveNonfiction.value);
                          },
                          child: Container(
                            height: 25,
                            width: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: controller.isActiveNonfiction.isTrue
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  controller.isActiveNonfiction.value
                                      ? controller.lang.value == "en"
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.end
                                      : controller.lang.value == "en"
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 22,
                                  width: 22,
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 2),
                                          blurRadius: 5,
                                          color: Colors.black.withOpacity(0.3),
                                        )
                                      ],
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault,
                        vertical: Dimensions.paddingSizeSmall),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              Images.languageSetting,
                              scale: 2,
                            ),
                            const SizedBox(
                              width: Dimensions.paddingSizeLarge,
                            ),
                            Text(
                              'language'.tr,
                              style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeLarge),
                            ),
                          ],
                        ),
                        Obx(() => DropdownButton<String>(
                              isDense: true,
                              style: textMedium.copyWith(
                                  color: Theme.of(context).primaryColor),
                              value: controller.lang.value == 'en'
                                  ? 'English'
                                  : 'عربي',
                              underline: const SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down_sharp),
                              elevation: 1,
                              selectedItemBuilder: (_) {
                                return <String>['English', 'عربي']
                                    .map<Widget>((String item) {
                                  return Center(
                                    child: Text(
                                      item,
                                      style: textRegular.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color),
                                    ),
                                  );
                                }).toList();
                              },
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'English',
                                  child: Text(
                                    'English',
                                    style: textRegular.copyWith(
                                        color: controller.settingModel.value
                                                    .lang.value ==
                                                'en'
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'عربي',
                                  child: Text(
                                    'عربي',
                                    style: textRegular.copyWith(
                                        color: controller.settingModel.value
                                                    .lang.value ==
                                                'ar'
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color),
                                  ),
                                ),
                              ],
                              onChanged: (lang) {
                                controller.isUpdateMode(true);
                                lang = lang == "English" ? "en" : "ar";
                                controller.lang(lang);
                              },
                            ))
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'theme'.tr,
                      style: textRegular.copyWith(),
                    ),
                    leading: Image.asset(
                      Images.themeLogo,
                      width: 20,
                    ),
                  ),
                  GetBuilder<ThemeController>(builder: (themeController) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeDefault),
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.isUpdateMode(true);
                                  controller.isActiveDark(false);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.2),
                                      ),
                                      child: controller.isActiveDark.isFalse
                                          ? const Center(
                                              child: Icon(
                                                Icons.circle,
                                                size: 10,
                                                color: Colors.black,
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text('light'.tr),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: Dimensions.paddingSizeLarge,
                              ),
                              InkWell(
                                onTap: () {
                                  controller.isUpdateMode(true);
                                  controller.isActiveDark(true);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.2),
                                      ),
                                      child: controller.isActiveDark.isTrue
                                          ? const Center(
                                              child: Icon(
                                                Icons.circle,
                                                size: 10,
                                                color: Colors.black,
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text('dark'.tr),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    );
                  }),
                  ListTile(
                    title: Text(
                      'change_password'.tr,
                      style: textMedium.copyWith(),
                    ),
                    leading: Image.asset(Images.password,
                        width: 20,
                        height: 20,
                        color: Theme.of(context).primaryColor),
                    onTap: () async {
                      Get.to(
                        () => const ResetPasswordScreen(
                          fromChangePassword: true,
                        ),
                        binding: BindingsBuilder(
                          () {
                            Get.lazyPut(() => AuthController(sl()));
                          },
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'delete_acc'.tr,
                      style: textMedium.copyWith(),
                    ),
                    leading: Image.asset(Images.delete,
                        width: 20,
                        height: 20,
                        color: Theme.of(context).primaryColor),
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return ConfirmationDialog(
                              icon: Images.delete,
                              title: 'delete_acc'.tr,
                              description:
                                  'do_you_want_to_delete_this_account'.tr,
                              onYesPressed: () async {
                                if (await sl<AuthCases>().isAuthenticated()) {
                                  await sl<AuthCases>().deleteAcc();
                                  await sl<AuthCases>().setUserDate(null);
                                }
                              },
                            );
                          });
                    },
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Obx(() => Visibility(
                          visible: controller.isUpdateMode.isTrue,
                          child: CustomButton(
                            buttonText: 'update_settings'.tr,
                            radius: 20,
                            isLoading: controller.isLoading.isTrue,
                            onPressed: controller.saveSettingToRemote,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
