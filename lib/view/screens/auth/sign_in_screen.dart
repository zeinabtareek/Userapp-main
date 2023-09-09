import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/otp_log_in_screen.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_up_screen.dart';
import 'package:ride_sharing_user_app/view/screens/html/html_viewer_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../forgot_password/forget_password_screen.dart';

class SignInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: GetBuilder<AuthController>(
          builder: (authController) {

        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: K.fixedPadding0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        Images.logo,
                        width: 150,
                      ),
                      K.sizedBoxH2,
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
                    inputType: TextInputType.number,
                    countryDialCode: "+20",
                    prefixHeight: 70,
                    controller: authController.signInPhoneController,
                    focusNode: authController.signInPhoneNode,
                    nextFocus: authController.passwordNode,
                    inputAction: TextInputAction.next,
                    onCountryChanged: (countryCode)=>authController.onCountryChanged(countryCode,authController.signInPhoneController)
                  ),
                  K.sizedBoxH0,
                  CustomTextField(
                    hintText: Strings.passwordHint.tr,
                    inputType: TextInputType.text,
                    prefixIcon: Images.lock,
                    prefixHeight: 70,
                    inputAction: TextInputAction.done,
                    isPassword: true,
                    controller: authController.signInPasswordController,
                    focusNode: authController.signInpasswordNode,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          onTap: () => authController.toggleRememberMe(),
                          title: Row(
                            children: [
                              SizedBox(
                                width: 20.0,
                                child: Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  activeColor: Theme.of(context).primaryColor,
                                  value: authController.isActiveRememberMe,
                                  onChanged: (bool? isChecked) =>
                                      authController.toggleRememberMe(),
                                ),
                              ),
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
                          onPressed: () {
                            Get.to(() =>   ForgotPasswordScreen());
                          },
                          child: Text(
                            Strings.forgotPassword.tr,
                            style: K.primarySmallTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                  CustomButton(
                    buttonText: Strings.logIn.tr,
                    isLoading: false,
                    onPressed: () => authController.validationLoginPress(),
                    radius: 50,
                  ),
                  Row(children: [
                    const Expanded(
                      child: Divider(),
                    ),
                    K.sizedBoxH1,
                    Text(
                      Strings.or.tr,
                      style: K.hintMediumTextStyle,
                    ),
                    K.sizedBoxH1,
                    const Expanded(
                      child: Divider(),
                    ),
                  ]),
                  CustomButton(
                    showBorder: true,
                    borderWidth: 1,
                    transparent: true,
                    isLoading: false,
                    buttonText: Strings.otpLogin.tr,
                    onPressed: () {
                      Get.to(() => const OtpLoginScreen(fromSignIn: true));
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
                            Get.to(() => const SignUpScreen() ,);
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
        );
      }),
    );
  }
}

