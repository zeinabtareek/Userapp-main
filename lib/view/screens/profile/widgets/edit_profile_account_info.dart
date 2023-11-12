import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/validator.dart';

import '../../../../authenticate/presentation/widgets/test_field_title.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/images.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../profile_screen/controller/user_controller.dart';

class EditProfileAccountInfo extends StatelessWidget {
  const EditProfileAccountInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: UserController(),
        builder: (controller) {
          return Form(
            key:controller.editProfileScreenKey ,
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          TextFieldTitle(
                          title: Strings.firstName.tr,
                          textOpacity: 0.8,
                        ),
                        CustomTextField(
                          isLtr: true,
                          validator: (p0) => TValidator.normalValidator(p0,hint: Strings.firstName.tr ),
                          isEnabled: controller.isEnabledForEdit,
                          hintText: Strings.enterYourName.tr,
                          inputType: TextInputType.name,
                          prefixIcon: Images.person,
                          controller: controller.fristNameController,
                          inputAction: TextInputAction.next,
                          onChanged: (_) => controller.isCanUpdate(true),
                        ),
                          TextFieldTitle(
                          title: Strings.lastName.tr,
                          textOpacity: 0.8,
                        ),
                        CustomTextField(
                          hintText: Strings.enterYourName.tr,
                          isLtr: true,
                          validator: (p0) => TValidator.normalValidator(p0,hint: Strings.lastName.tr ),
                          inputType: TextInputType.name,
                          isEnabled: controller.isEnabledForEdit,
                          prefixIcon: Images.person,
                          controller: controller.lastNameController,
                          inputAction: TextInputAction.next,
                          onChanged: (_) => controller.isCanUpdate(true),
                        ),
                        TextFieldTitle(
                          title: Strings.
                          phone.tr,
                        ),
                        CustomTextField(
                          isEnabled: false,
                          isLtr: true,
                          hintText: Strings.enterYourPhoneNumber.tr,
                          inputType: TextInputType.number,
                          countryDialCode: controller.defaultDailCode,
                          inputAction: TextInputAction.next,
                          controller: controller.phoneController,
                        ),
                        TextFieldTitle(
                          title: Strings.email.tr,
                          textOpacity: 0.8,
                        ),
                        CustomTextField(
                          hintText: Strings.enterYourEmail.tr,
                          inputType: TextInputType.emailAddress,
                          isEnabled: controller.isEnabledForEdit,
                          prefixIcon: Images.email,
                          isLtr: true,
                          validator: (p0) => TValidator.email(p0, Strings.email.tr),
                          controller: controller.emailController,
                          inputAction: TextInputAction.next,
                          onChanged: (_) => controller.isCanUpdate(true),
                        ),
                        TextFieldTitle(
                          title: Strings.address.tr,
                          textOpacity: 0.8,
                        ),
                        CustomTextField(
                          hintText: Strings.enterYourAddress.tr,
                          isEnabled: controller.isEnabledForEdit,
                          inputType: TextInputType.text,
                          prefixIcon: Images.location,
                          isLtr: true,
                          validator: (p0) => TValidator.normalValidator(p0,hint:  Strings.address.tr),
                          controller: controller.addressController,
                          inputAction: TextInputAction.next,
                          onChanged: (_) => controller.isCanUpdate(true),
                        ),
                      ]),
                )),
                const SizedBox(height: 30),
                Obx(() => Visibility(
                      visible: controller.isCanUpdate.isTrue,
                      child: CustomButton(
                        radius: 50,
                        isLoading: controller.isLoading.isTrue,
                        buttonText: Strings.updateProfile.tr,
                        onPressed: controller.submitEdit,
                      ),
                    ))
              ],
            ),
          );
        });
  }
}
