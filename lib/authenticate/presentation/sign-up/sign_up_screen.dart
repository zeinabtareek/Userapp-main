import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/images.dart';
import '../../../view/screens/auth/widgets/test_field_title.dart';
import '../../../view/widgets/custom_button.dart';
import '../../../view/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';

class SignUpScreen extends GetView<AuthController> {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Center(
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
                          controller: controller.regFristNameController,
                          focusNode: controller.regFristNameFocusNode,
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
                  inputType: TextInputType.number,
                  countryDialCode: "+20",
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
                  hintText: Strings.passwordHint.tr,
                  inputType: TextInputType.text,
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
                  prefixIcon: Images.password,
                  controller: controller.regNewPassController,
                  focusNode: controller.regNewPassFocusNode,
                  inputAction: TextInputAction.done,
                  isPassword: true,
                ),
                K.sizedBoxH0,
                K.sizedBoxH0,
                K.sizedBoxH0,
                CustomButton(
                  buttonText: Strings.next.tr,
                  onPressed: () async {
                    await controller.validationSignUp();
                  },
                  radius: 50,
                ),
                K.sizedBoxH2
              ],
            ),
          ),
        ),
      ),
    );
  }
}
