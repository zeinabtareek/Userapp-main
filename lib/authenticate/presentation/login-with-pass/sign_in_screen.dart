import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_constants.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/text_style.dart';
import '../../../util/validator.dart';
import '../../../view/screens/html/html_viewer_screen.dart';
import '../../../view/widgets/custom_button.dart';
import '../../../view/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';
import '../login-with-otp/otp_log_in_screen.dart';
import '../sign-up/sign_up_screen.dart';

class SignInScreen extends GetView<AuthController> {
  SignInScreen({super.key}) {
    controller.initLoginWithPassScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   //   backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: K.fixedPadding0,
              child: Form(
                key: controller.loginWithPassKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          Images.logo,
                          width: 150,
                        ),
                        // K.sizedBoxH2,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${Strings.welcomeTo.tr} ${AppConstants.appName}',
                                style: K.primaryMediumTextStyle,
                              ),
                              Image.asset(Images.hand, width: 40),
                            ])
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    Text(Strings.logIn.tr, style: K.primaryMediumTextStyle),
                    K.sizedBoxH3,
                    Text(Strings.logInMessage.tr,
                        style: K.hintMediumTextStyle, maxLines: 2),
                    K.sizedBoxH1,
                    CustomTextField(
                      hintText: Strings.phone.tr,
                      isLtr: true,
                      validator: (p0) => TValidator.saudiNumber(
                        value: p0,
                        hint: Strings.phone.tr,
                      ),
                      inputType: TextInputType.number,
                      countryDialCode: defaultDailCode,
                      prefixHeight: 70,
                      controller: controller.loginPhoneController,
                      focusNode: null,
                      nextFocus: null,
                      inputAction: TextInputAction.next,
                      onCountryChanged: controller.loginSelectCountry,
                    ),
                    K.sizedBoxH0,
                    CustomTextField(
                      isLtr: true,
                      validator: (p0) => TValidator.passwordValidate(
                          value: p0, hint: Strings.passwordHint.tr),
                      hintText: Strings.passwordHint.tr,
                      inputType: TextInputType.text,
                      prefixIcon: Images.lock,
                      prefixHeight: 70,
                      inputAction: TextInputAction.done,
                      isPassword: true,
                      controller: controller.loginPassController,
                      onFieldSubmitted: (text) => controller.loginWithPass(),
                      focusNode: null,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            onTap: controller.toggleRememberMe,
                            title: Row(
                              children: [
                                Obx(() => SizedBox(
                                      width: 20.0,
                                      child: Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        value:
                                            controller.isLoginRememberMe.value,
                                        onChanged: (bool? isChecked) =>
                                            controller.toggleRememberMe(),
                                      ),
                                    )),
                                K.sizedBoxH3,
                                Text(
                                  Strings.remember.tr,
                                  style: textRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall),
                                )
                              ],
                            ),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            horizontalTitleGap: 0,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: controller.toForgetPassScreen,
                            child: Text(
                              Strings.forgotPassword.tr,
                              style: K.primarySmallTextStyle,
                            ),
                          ),
                        )
                      ],
                    ),
                    Obx(
                      () => CustomButton(
                        buttonText: Strings.logIn.tr,
                        isLoading: controller.isLoginWithPassLoading.value,
                        onPressed: controller.loginWithPass,
                        radius: 50,
                      ),
                    ),
                    Row(children: [
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      K.sizedBoxW0,
                      Text(
                        Strings.or.tr,
                        style: K.hintMediumTextStyle,
                      ),
                      K.sizedBoxW0,
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ]),
                    CustomButton(
                      showBorder: true,
                      borderWidth: 1,
                      transparent: true,
                      isLoading: false,
                      buttonText: Strings.otpLogin.tr,
                      onPressed: () {
                        Get.to(() => const OtpLoginScreen());
                      },
                      radius: 50,
                    ),
                    K.sizedBoxH0,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${Strings.doNotHaveAnAccount.tr} ',
                          style: K.hintSmallTextStyle,
                        ),
                        TextButton(
                            onPressed: () {
                              // TODO:
                              Get.to(
                                () => SignUpScreen(),
                              );
                            },
                            child: Text(Strings.signUp.tr,
                                style: K.primaryWithUnderLineSmallTextStyle))
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    InkWell(
                      onTap: () => Get.to(() => const HtmlViewerScreen()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Strings.termsAndCondition.tr,
                              style: K.primaryWithUnderLineSmallTextStyle)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
