import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/display_helper.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/text_style.dart';
import '../../../view/screens/html/html_viewer_screen.dart';
import '../../../view/widgets/custom_button.dart';
import '../../../view/widgets/custom_text_field.dart';
import '../../enums/auth_enums.dart';
import '../controller/auth_controller.dart';
import '../forgot_password/verification_screen.dart';
import '../login-with-pass/sign_in_screen.dart';
import '../sign-up/sign_up_screen.dart';

class OtpLoginScreen extends GetView<AuthController> {
  const OtpLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
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
                    Image.asset(
                      Images.otpScreenLogo,
                      width: 150,
                    ),
                    K.sizedBoxH0,
                    Row()
                  ],
                ),
                K.sizedBoxH0,
                Text(
                  Strings.otpForgetPassword.tr,
                  style: K.primaryMediumTextStyle,
                ),
                Text(
                  Strings.enterYourPhoneNumber.tr,
                  style: K.hintSmallTextStyle,
                ),
                K.sizedBoxH0,
                CustomTextField(
                  hintText: Strings.phone,
                  inputType: TextInputType.number,
                  countryDialCode: defaultDailCode ,
                  prefixHeight: 70,
                  controller: controller.phoneControllerForOTPLogInScreen,
                  focusNode: controller.nodeForOTPLogInScreen,
                  inputAction: TextInputAction.done,
                  onCountryChanged: controller.otpSelectCountry,
                ),
                K.sizedBoxH0,
                K.sizedBoxH0,
                CustomButton(
                  buttonText: Strings.sendOtp.tr,
                  onPressed: controller.loginOtpClick,
                  radius: 50,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall, vertical: 8),
                      child: Text(
                        Strings.or.tr,
                        style: textRegular.copyWith(
                            color: Theme.of(context).hintColor),
                      ),
                    ),
                    const Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                CustomButton(
                  showBorder: true,
                  borderWidth: 1,
                  transparent: true,
                  buttonText: Strings.logIn.tr,
                  onPressed: () {
                    Get.to(() => SignInScreen());
                  },
                  radius: 50,
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.doNotHaveAnAccount.tr,
                      style: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const SignUpScreen());
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(Strings.signUp.tr,
                          style: textMedium.copyWith(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeSmall,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () => Get.to(() => const HtmlViewerScreen()),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Text(Strings.termsAndCondition.tr,
                          style: textMedium.copyWith(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeSmall,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
