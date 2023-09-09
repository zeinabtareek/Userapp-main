import 'package:country_code_picker/country_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ride_sharing_user_app/view/screens/forgot_password/verify_forget_password_otp_screen.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../html/html_viewer_screen.dart';
import '../auth/controller/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: GetBuilder<AuthController>(builder: (authController){
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:   K.fixedPadding0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(Images.logo, width: 150,),
                    K.sizedBoxH0,
                    K.sizedBoxH0,
                      Image.asset(Images.otpScreenLogo, width: 150,),
                      K.sizedBoxH0,
                      Row()
                    ],
                  ),

                  Text(Strings.otpForgetPassword.tr,
                    style: K.primaryMediumTextStyle,),

                  Text(Strings.enterYourPhoneNumber.tr,
                    style: K.hintSmallTextStyle,),

                    const SizedBox(height: Dimensions.paddingSizeLarge,),

                  CustomTextField(
                    hintText: Strings.phone.tr,
                    inputType: TextInputType.number,
                    countryDialCode: "+20",
                    prefixHeight: 70,
                    controller: authController.forgetPasswordPhoneController,
                    focusNode: authController.forgetPasswordPhoneNode,
                    inputAction: TextInputAction.done,
                      onCountryChanged: (countryCode)=>authController.onCountryChanged(countryCode,authController.forgetPasswordPhoneController)

                  ),
                 K.sizedBoxH0,
                  CustomButton(
                    buttonText: Strings.sendOtp.tr,
                    onPressed: (){
                      Get.to(const VerifyForgetPasswordOtpScreen());

                    },
                    radius: 50,
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
                    onPressed: (){
                      Get.back();
                    }, radius: 50,
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