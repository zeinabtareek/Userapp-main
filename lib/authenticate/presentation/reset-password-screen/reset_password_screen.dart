import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/validator.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../view/widgets/custom_app_bar.dart';
import '../../../view/widgets/custom_body.dart';
import '../../../view/widgets/custom_button.dart';
import '../../../view/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';
import '../widgets/test_field_title.dart';

/// for ChangePassword foe exsit user we will use token
/// so don't need phone or countryCode or otpCode
class ResetPasswordScreen extends GetView<AuthController> {
  final String? phone;
  final String? countryCode;
  final bool fromChangePassword;
  final String? otpCode;
  const ResetPasswordScreen({
    Key? key,
    this.fromChangePassword = false,
    this.countryCode,
    this.otpCode,
    this.phone,
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
                    validator: (p0) => TValidator.passwordValidate(
                        value: p0, hint: Strings.oldPassword.tr),
                    prefixIcon: Images.password,
                    isLtr: true,
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
                  isLtr: true,
                  hintText: Strings.passwordHint.tr,
                  inputType: TextInputType.text,
                  prefixIcon: Images.password,
                  validator: (p0) => TValidator.passwordValidate(
                      value: p0, hint: Strings.newPassword.tr),
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
                  isLtr: true,
                  inputType: TextInputType.text,
                  validator: (p0) => TValidator.confirmPasswordValidate(
                    value: p0,
                    comparePassword: controller.resetNewPasswordController.text,
                    hint: Strings.confirmNewPassword.tr,
                  ),
                  prefixIcon: Images.password,
                  controller: controller.resetConfirmPasswordController,
                  focusNode: controller.resetConfirmPasswordFocusNode,
                  inputAction: TextInputAction.done,
                  onFieldSubmitted: (text) =>  _onSubmit(),
                  isPassword: true,
                ),
                K.sizedBoxH0,
                Obx(() => CustomButton(
                      buttonText: fromChangePassword
                          ? Strings.update.tr
                          : Strings.save.tr,
                      isLoading: controller.resetPassScreenIsLoading.isTrue,
                      onPressed: _onSubmit,
                      radius: 50,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onSubmit() async {
                      if (controller.resetKey.currentState!.validate()) {
                          if (fromChangePassword) {
                        await controller.changePass();
                      } else {
                        controller.resetPass(countryCode!, otpCode!, phone!);
                      } 
                      }
                   
                    }
}
