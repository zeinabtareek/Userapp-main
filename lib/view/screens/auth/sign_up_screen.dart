import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/test_field_title.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.logo,
                          width: 120,
                        ),
                        K.sizedBoxH0,
                        Image.asset(
                          Images.signUpScreenLogo,
                          width: 150,
                        ),
                        K.sizedBoxH0,
                      ],
                    ),
                  ),

                  K.sizedBoxH0,
                  Text(Strings.signUp.tr, style: K.primarySmallTextStyle),
                  K.sizedBoxH0,
                  Text(
                    Strings.signUpMessage.tr,
                    style: K.hintMediumTextStyle,
                    maxLines: 2,
                  ),
                  K.sizedBoxH3,
                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldTitle(
                            title: Strings.firstName.tr,
                          ),
                          CustomTextField(
                            hintText: Strings.firstName.tr,
                            inputType: TextInputType.name,
                            prefixIcon: Images.person,
                            controller: authController.fNameController,
                            focusNode: authController.fNameNode,
                            nextFocus: authController.lNameNode,
                            inputAction: TextInputAction.next,
                          )
                        ],
                      ),
                    ),
                    K.sizedBoxW0,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldTitle(
                            title: Strings.lastName.tr,
                          ),
                          CustomTextField(
                            hintText: Strings.lastName.tr,
                            inputType: TextInputType.name,
                            prefixIcon: Images.person,
                            controller: authController.lNameController,
                            focusNode: authController.lNameNode,
                            nextFocus: authController.signupPhoneNode,
                            inputAction: TextInputAction.next,
                          )
                        ],
                      ),
                    )
                  ]),

                  TextFieldTitle(
                    title: Strings.phone.tr,
                  ),
                  CustomTextField(
                    hintText: Strings.phone.tr,
                    inputType: TextInputType.number,
                    countryDialCode: "+20",
                    controller: authController.signupPhoneController,
                    focusNode: authController.signupPhoneNode,
                    nextFocus: authController.passwordNode,
                    inputAction: TextInputAction.next,
                      onCountryChanged: (countryCode)=>authController.onCountryChanged(countryCode,authController.signupPhoneController)

                  ),

                  TextFieldTitle(
                    title: Strings.passwordHint.tr,
                  ),
                  CustomTextField(
                    hintText: Strings.passwordHint.tr,
                    inputType: TextInputType.text,
                    prefixIcon: Images.password,
                    isPassword: true,
                    controller: authController.signupPasswordController,
                    focusNode: authController.passwordNode,
                    nextFocus: authController.signupConfirmPasswordNode,
                    inputAction: TextInputAction.next,
                  ),

                  TextFieldTitle(
                    title: Strings.confirmPassword.tr,
                  ),
                  CustomTextField(
                    hintText: '•••••••••••',
                    inputType: TextInputType.text,
                    prefixIcon: Images.password,
                    controller: authController.confirmPasswordController,
                    focusNode: authController.signupConfirmPasswordNode,
                    inputAction: TextInputAction.done,
                    isPassword: true,
                  ),
                  K.sizedBoxH0,
                  K.sizedBoxH0,
                  K.sizedBoxH0,
                  CustomButton(
                    buttonText: Strings.next.tr,
                    onPressed: ()async{
                     await authController. validationSignUp();

                        // if(authController.fNameController.text.isEmpty){
                        //   showCustomSnackBar(Strings.firstNameIsRequired.tr);
                        // }
                        // else
                        // if( lNameController.text.isEmpty){
                        //   showCustomSnackBar(Strings.lastNameIsRequired.tr);
                        // }else if(signupPhoneController.text.isEmpty){
                        //   showCustomSnackBar(Strings.phoneIsRequired.tr);
                        // }else if(signupPhoneController.text.length<8){
                        //   showCustomSnackBar(Strings.invalidPhone.tr);
                        // }else if(signupPasswordController.text.isEmpty){
                        //   showCustomSnackBar(Strings.passIsRequired.tr);
                        // }else if(confirmPasswordController.text.length<8){
                        //   showCustomSnackBar(Strings.minPassLength.tr);
                        // }else if(confirmPasswordController.text.isEmpty){
                        //   showCustomSnackBar(Strings.confirmPasswordIsRequired.tr);
                        // }else if(signupPhoneController.text != confirmPasswordController.text){
                        //   showCustomSnackBar(Strings.passwordIsMismatch.tr);
                        // }
                        // else{
                        //   SignUpBody signUpBody = SignUpBody(
                        //       fName: authController.fNameController.text,
                        //       lName: authController.lNameController.text,
                        //       phone:authController. signupPhoneController.text,
                        //       password:authController. signupPasswordController.text,
                        //       confirmPassword: authController.confirmPasswordController.text
                        //   );
                        //   if (kDebugMode) {
                        //     print(signUpBody);
                        //   } authController.setUserToken(AppConstants.signUpBody).then((value){
                        //     Get.to(const AdditionalSignUpScreen());
                        //   });
                        //
                        // }

                    },
                    radius: 50,
                  ),
                  K.sizedBoxH2
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}




