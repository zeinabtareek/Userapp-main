import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../helper/display_helper.dart';
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
import 'reset_password_screen.dart';

class VerificationScreen extends GetView<AuthController> {
  final String number;
  final OtpState otpState;
  const VerificationScreen({
    Key? key,
    required this.number,
    required this.otpState,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: Strings.forgetPassword.tr),
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
                    validator: (value) {
                      // TODO:
                    },
                    beforeTextPaste: (text) => true,
                    textStyle: textSemiBold.copyWith(),
                    pastedTextStyle: textRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium!.color),
                  ),
                ),
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
                      TextButton(
                        onPressed: () {
                          showCustomSnackBar(Strings.otpSentSuccessfully.tr,
                              isError: false);
                        },
                        child: Text(
                          Strings.resendIt.tr,
                          style: K.hintMediumTextStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
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
                            onPressed: () {
                              if (otpState == OtpState.loginWithOtp ||
                                  otpState == OtpState.register) {
                                Get.offAll(() => DashboardScreen());
                              } else {
                                Get.to(
                                  () =>  ResetPasswordScreen(
                                    phone: number,
                                  ),
                                );
                              }
                            },
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
}
