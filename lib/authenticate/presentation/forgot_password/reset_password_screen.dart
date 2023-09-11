import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../view/screens/auth/widgets/test_field_title.dart';
import '../../../view/widgets/custom_app_bar.dart';
import '../../../view/widgets/custom_body.dart';
import '../../../view/widgets/custom_button.dart';
import '../../../view/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';

class ResetPasswordScreen extends GetView<AuthController> {
  final String phone;
  final bool fromChangePassword;
  const ResetPasswordScreen({
    Key? key,
    this.fromChangePassword = false,
    required this.phone,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(
          title: fromChangePassword
              ? Strings.changePassword.tr
              : Strings.resetPassword.tr,
          showBackButton: true,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Form(
            key: controller.resetKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (fromChangePassword)
                  TextFieldTitle(
                    title: Strings.oldPassword.tr,
                  ),
                if (fromChangePassword)
                  
                  CustomTextField(
                    hintText: Strings.passwordHint.tr,
                    inputType: TextInputType.text,
                    prefixIcon: Images.password,
                    isPassword: true,
                    controller: controller.resetOldPasswordController,
                    focusNode: controller.resetOldPasswordFocus,
                    nextFocus: controller.resetNewPasswordFocusNode,
                    inputAction: TextInputAction.next,
                  ),
                TextFieldTitle(
                  title: Strings.newPassword.tr,
                ),
             
                CustomTextField(
                  hintText: Strings.passwordHint.tr,
                  inputType: TextInputType.text,
                  prefixIcon: Images.password,
                  isPassword: true,
                  controller: controller.resetNewPasswordController,
                  focusNode: controller.resetNewPasswordFocusNode,
                  nextFocus: controller.resetConfirmPasswordFocusNode,
                  inputAction: TextInputAction.next,
                ),
                TextFieldTitle(
                  title: Strings.confirmNewPassword.tr,
                ),
          
                CustomTextField(
                  hintText: '•••••••••••',
                  inputType: TextInputType.text,
                  prefixIcon: Images.password,
                  controller: controller.resetConfirmPasswordController,
                  focusNode: controller.resetConfirmPasswordFocusNode,
                  inputAction: TextInputAction.done,
                  isPassword: true,
            
                ),
                K.sizedBoxH0,
                Obx(() => CustomButton(
                      buttonText: fromChangePassword
                          ? Strings.update.tr
                          : Strings.save.tr,
                      isLoading: controller.resetPassScreenIsLoading.isTrue,
                      onPressed: () async {
                         
                        // await controller.confirmPassValidation();
                      },
                      radius: 50,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
