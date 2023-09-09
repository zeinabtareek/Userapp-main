import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_in_screen.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_up_screen.dart';
import 'package:ride_sharing_user_app/view/screens/forgot_password/verification_screen.dart';
import 'package:ride_sharing_user_app/view/screens/html/html_viewer_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';

class OtpLoginScreen extends StatelessWidget {
  final bool fromSignIn;
  const OtpLoginScreen({Key? key, this.fromSignIn = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String countryDialCode = CountryCode.fromCountryCode("BD").dialCode!;
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: GetBuilder<AuthController>(builder: (authController){
        return Center(
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
                      Image.asset(Images.logo, width: 150,),
                      K.sizedBoxH0,
                      Image.asset(Images.otpScreenLogo, width: 150,),
                      K.sizedBoxH0,
                      Row()
                    ],
                  ), K.sizedBoxH0,
                  Text(Strings.otpForgetPassword.tr,
                    style: K.primaryMediumTextStyle,),
                  Text(Strings.enterYourPhoneNumber.tr,
                    style: K.hintSmallTextStyle,),
                  K.sizedBoxH0,
                  CustomTextField(
                    hintText: Strings.phone,
                    inputType: TextInputType.number,
                    countryDialCode: "+20",
                    prefixHeight: 70,
                    controller: authController.phoneControllerForOTPLogInScreen,
                    focusNode: authController.nodeForOTPLogInScreen,
                    inputAction: TextInputAction.done,
                      onCountryChanged: (countryCode)=>authController.onCountryChanged(countryCode,authController.phoneControllerForOTPLogInScreen)),
                  K.sizedBoxH0,
                  K.sizedBoxH0,
                  CustomButton(
                    buttonText: Strings.sendOtp.tr,
                    onPressed: (){
                      String phone =authController. phoneControllerForOTPLogInScreen.text;

                      if(phone.length<8){
                        showCustomSnackBar(Strings.invalidPhone.tr);
                      }else{
                        Get.to(()=> VerificationScreen(number: phone, fromOtpLogin: fromSignIn));
                      }
                    },
                    radius: 50,
                  ),
                  Row(
                    children: [
                      const Expanded(child: Divider(),),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: 8),
                        child: Text(Strings.or.tr ,style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                      ),
                      const Expanded(child: Divider(),),
                    ],
                  ),
                  CustomButton(
                    showBorder: true,
                    borderWidth: 1,
                    transparent: true,
                    buttonText: Strings.logIn.tr,
                    onPressed: (){
                        Get.to(()=>  SignInScreen());
                    },
                    radius: 50,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Strings.doNotHaveAnAccount.tr,
                        style: textMedium.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).hintColor,
                        ),
                      ),

                      TextButton(
                        onPressed: (){
                          Get.to(()=>const SignUpScreen());
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50,30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                        ),
                        child: Text(Strings.signUp.tr, style: textMedium.copyWith(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).primaryColor,
                          fontSize: Dimensions.fontSizeSmall,
                        )),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: ()=> Get.to(()=> const HtmlViewerScreen()),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Text(Strings.termsAndCondition.tr, style: textMedium.copyWith(
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
        );
      }),
    );
  }
}
