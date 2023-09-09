import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/sign_in_screen.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/test_field_title.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';


class ResetPasswordScreen extends StatelessWidget {
  final bool fromChangePassword;
  const ResetPasswordScreen({Key? key,  this.fromChangePassword = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: fromChangePassword? Strings.changePassword.tr : Strings.resetPassword.tr, showBackButton: true,centerTitle: true,),
        body: GetBuilder<AuthController>(builder: (authController){
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(fromChangePassword)
                  TextFieldTitle(title: Strings.oldPassword.tr,),
                if(fromChangePassword)
                  CustomTextField(
                    hintText: Strings.passwordHint.tr,
                    inputType: TextInputType.text,
                    prefixIcon: Images.password,
                    isPassword: true,
                    controller: authController.oldPasswordController,
                    focusNode: authController.oldPasswordFocus,
                    nextFocus:authController. passwordFocusNode,
                    inputAction: TextInputAction.next,
                  ),

                TextFieldTitle(title: Strings.newPassword.tr,),
                CustomTextField(
                  hintText: Strings.passwordHint.tr,
                  inputType: TextInputType.text,
                  prefixIcon: Images.password,
                  isPassword: true,
                  controller: authController.resetPasswordController,
                  focusNode: authController.resetPasswordFocusNode,
                  nextFocus: authController.resetPasswordFocusNode,
                  inputAction: TextInputAction.next,
                ),

                TextFieldTitle(title: Strings.confirmNewPassword.tr,),
                CustomTextField(
                  hintText: '•••••••••••',
                  inputType: TextInputType.text,
                  prefixIcon: Images.password,
                  controller: authController.resetConfirmPasswordController,
                  focusNode: authController.resetConfirmPasswordFocusNode,
                  inputAction: TextInputAction.done,
                  isPassword: true,
                ),
               K.sizedBoxH0,
                CustomButton(
                  buttonText: fromChangePassword?Strings.update.tr : Strings.save.tr,
                  onPressed: ()async{
                   await authController.confirmPassValidation();
                  },
                  radius: 50,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
