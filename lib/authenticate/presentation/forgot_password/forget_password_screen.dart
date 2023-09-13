import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../view/screens/html/html_viewer_screen.dart';
import '../../../view/widgets/custom_button.dart';
import '../../../view/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';

class ForgotPasswordScreen extends GetView<AuthController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: K.fixedPadding0,
            child: Form(
              key: controller.forgetPasswordValidateKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.logo,
                        width: 150,
                      ),
                      K.sizedBoxH0,
                      K.sizedBoxH0,
                      Image.asset(
                        Images.otpScreenLogo,
                        width: 150,
                      ),
                      K.sizedBoxH0,
                      const Row()
                    ],
                  ),
                  Text(
                    Strings.otpForgetPassword.tr,
                    style: K.primaryMediumTextStyle,
                  ),
                  Text(
                    Strings.enterYourPhoneNumber.tr,
                    style: K.hintSmallTextStyle,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  CustomTextField(
                    validator: (p0) {
                      if (p0 != null && p0.isNotEmpty) {
                        return null;
                      } else {
                        return "";
                      }
                    },
                    hintText: Strings.phone.tr,
                    inputType: TextInputType.number,
                    countryDialCode: "+20",
                    prefixHeight: 70,
                    controller: controller.forgetPasswordPhoneController,
                    focusNode: controller.forgetPasswordPhoneNode,
                    inputAction: TextInputAction.done,
                    onCountryChanged: controller.forgetSelectCountry,
                  ),
                  K.sizedBoxH0,
                  Obx(
                    () => CustomButton(
                      buttonText: Strings.sendOtp.tr,
                      isLoading: controller.isForgetPassLoading.value,
                      onPressed: controller.forgetPassClick,
                      radius: 50,
                    ),
                  ),
                  K.sizedBoxH1,
                  Center(
                    child: Text(
                      Strings.or.tr,
                      style: K.hintMediumTextStyle,
                    ),
                  ),
                  K.sizedBoxH1,
                  CustomButton(
                    showBorder: true,
                    borderWidth: 1,
                    transparent: true,
                    buttonText: Strings.logIn.tr,
                    onPressed: () {
                      Get.back();
                    },
                    radius: 50,
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
    );
  }
}
