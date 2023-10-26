import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/text_style.dart';
import '../../../view/screens/dashboard/dashboard_screen.dart';
import '../../../view/widgets/custom_app_bar.dart';
import '../../../view/widgets/custom_body.dart';
import '../../../view/widgets/custom_button.dart';
import '../../enums/auth_enums.dart';
import '../controller/auth_controller.dart';
import '../reset-password-screen/reset_password_screen.dart';

class VerificationScreen extends GetView<AuthController> {
  final String number;
  final String countryCode;
  final OtpState otpState;
  VerificationScreen({
    Key? key,
    required this.number,
    required this.otpState,
    required this.countryCode,
  }) : super(key: key) {
    controller.initVerificationScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(
            title: _getTitle(),
            onBackPressed: () {
              controller.disposeVerificationScreen();
              Get.back();
            }),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.verification,
                  width: 120,
                ),
                K.sizedBoxH0,
                Text(
                  Strings.enterVerificationCode.tr,
                  style:
                      textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                ),
                K.sizedBoxH0,
                K.sizedBoxH0,
                SizedBox(
                  width: 240,
                  child: PinCodeTextField(
                    length: 4,
                    appContext: context,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.slide,
                    controller: controller.otpCodeController,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      fieldHeight: 40,
                      fieldWidth: 40,
                      borderWidth: 1,
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusDefault),
                      selectedColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),
                      selectedFillColor: Get.isDarkMode
                          ? Colors.grey.withOpacity(0.6)
                          : Colors.white,
                      inactiveFillColor: Theme.of(context).cardColor,
                      inactiveColor: Theme.of(context).hintColor,
                      activeColor: Theme.of(context).hintColor,
                      activeFillColor: Theme.of(context).cardColor,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    onChanged: controller.updateVerificationCode,
                    beforeTextPaste: (text) => true,
                    textStyle: textSemiBold.copyWith(),
                    pastedTextStyle: textRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium!.color),
                  ),
                ),
                Obx(() => Visibility(
                      visible: controller.isCounting.isTrue,
                      child: Center(
                        child: Text(
                          "${controller.min}:${controller.second}",
                          style: textRegular.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    )),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        Strings.didNotReceiveTheCode.tr,
                        style: textMedium.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .color!
                                .withOpacity(.6)),
                      ),
                      Obx(() => TextButton(
                            onPressed: controller.isCounting.isFalse
                                ? () {
                                    controller.reSendMsg(countryCode, number);
                                  }
                                : null,
                            child: Text(
                              Strings.resendIt.tr,
                              style: K.hintMediumTextStyle.copyWith(
                                color: controller.isCounting.isTrue
                                    ? null
                                    : Theme.of(context).primaryColor,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          )),
                    ]),
                K.sizedBoxH0,
                K.sizedBoxH0,
                Obx(() {
                  return controller.updateVerificationCode.value.length == 4
                      ? Padding(
                          padding: const EdgeInsets.only(
                            top: Dimensions.paddingSizeExtraLarge,
                          ),
                          child: CustomButton(
                            buttonText: Strings.send.tr,
                            isLoading:
                                controller.isVerificationIsLoading.isTrue,
                            radius: 50,
                            onPressed: _onCheckSuccess,
                          ),
                        )
                      : const SizedBox.shrink();
                }),
                K.sizedBoxH0,
                K.sizedBoxH0,
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTitle() {
    switch (otpState) {
      case OtpState.forgetPassword:
        return Strings.forgetPassword.tr;
      case OtpState.loginWithOtp:
        return Strings.otpLogin.tr;
      case OtpState.register:
        return Strings.signUp.tr;
      
    }
  }

  _onCheckSuccess() {
    if (otpState == OtpState.register) {
      controller.verifyPhone(number, countryCode);
    } else if (otpState == OtpState.loginWithOtp) {
      controller.loginWithOtp(number, countryCode);
    } else if (otpState == OtpState.forgetPassword) {
      controller.checkOtpCode(
        number,
        countryCode,
        onCheckSuccess: () {
          Get.off(
            () => ResetPasswordScreen(
              phone: number,
              countryCode: countryCode,
              otpCode: controller.updateVerificationCode.value,
              fromChangePassword: false,
            ),
          );
        },
      );
    }
  }
}
