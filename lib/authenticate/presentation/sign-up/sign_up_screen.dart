import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/validator.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/images.dart';
import '../../../view/widgets/custom_button.dart';
import '../../../view/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';
import '../widgets/test_field_title.dart';

class SignUpScreen extends GetView<AuthController> {
  SignUpScreen({Key? key}) : super(key: key) {
    if (kDebugMode) {
      controller.regFirstNameController.text = "aaa";
      controller.regLastNameController.text = 'jjj';
      controller.regNewPassController.text = '12345678';
      // controller.regPhoneController
      controller.regPassController.text = '12345678';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Theme.of(context).canvasColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: K.fixedPadding0,
            child: Form(
              key: controller.signUpKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  K.sizedBoxH0,
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
                            isLtr: true,
                            hintText: Strings.firstName.tr,
                            validator: (p0) => TValidator.normalValidator(
                              p0,
                              hint: Strings.firstName.tr,
                            ),
                            inputType: TextInputType.name,
                            prefixIcon: Images.person,
                            controller: controller.regFirstNameController,
                            focusNode: controller.regFirstNameFocusNode,
                            nextFocus: controller.regLastNameFocusNode,
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
                            isLtr: true,
                            validator: (p0) => TValidator.normalValidator(p0,
                                hint: Strings.lastName.tr),
                            hintText: Strings.lastName.tr,
                            inputType: TextInputType.name,
                            prefixIcon: Images.person,
                            controller: controller.regLastNameController,
                            focusNode: controller.regLastNameFocusNode,
                            nextFocus: controller.regPhoneFocusNode,
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
                    isLtr: true,
                    validator: (p0) => TValidator.saudiNumber(
                      value: p0,
                      hint: Strings.phone.tr,
                    ),
                    inputType: TextInputType.number,
                    countryDialCode: defaultDailCode,
                    controller: controller.regPhoneController,
                    focusNode: controller.regPhoneFocusNode,
                    nextFocus: controller.regPasswordFocusNode,
                    inputAction: TextInputAction.next,
                    onCountryChanged: controller.regSelectCountry,
                  ),
                  TextFieldTitle(
                    title: Strings.passwordHint.tr,
                  ),
                  CustomTextField(
                    validator: (p0) => TValidator.passwordValidate(
                        value: p0, hint: Strings.passwordHint.tr),
                    hintText: Strings.passwordHint.tr,
                    inputType: TextInputType.text,
                    isLtr: true,
                    prefixIcon: Images.password,
                    isPassword: true,
                    controller: controller.regPassController,
                    focusNode: controller.regPasswordFocusNode,
                    nextFocus: controller.regNewPassFocusNode,
                    inputAction: TextInputAction.next,
                  ),
                  TextFieldTitle(
                    title: Strings.confirmPassword.tr,
                  ),
                  CustomTextField(
                    hintText: '•••••••••••',
                    inputType: TextInputType.text,
                    isLtr: true,
                    validator: (p0) => TValidator.confirmPasswordValidate(
                      value: p0,
                      comparePassword: controller.regPassController.text,
                      hint: Strings.confirmPassword.tr,
                    ),
                    prefixIcon: Images.password,
                    controller: controller.regNewPassController,
                    focusNode: controller.regNewPassFocusNode,
                    inputAction: TextInputAction.done,
                    onFieldSubmitted: (text) async =>
                        await controller.validationSignUp(),
                    isPassword: true,
                  ),
                  K.sizedBoxH0,
                  K.sizedBoxH0,
                  K.sizedBoxH0,
                  Obx(() => CustomButton(
                        isLoading: controller.isLoadingSignUp.isTrue,
                        buttonText: Strings.next.tr,
                        onPressed: () async {
                          await controller.validationSignUp();
                        },
                        radius: 50,
                      )),
                  K.sizedBoxH2
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
