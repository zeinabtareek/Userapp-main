import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

import '../../../../authenticate/presentation/widgets/test_field_title.dart';
import '../../../../util/app_strings.dart';
import '../profile_screen/controller/user_controller.dart';

class EditProfileAccountInfo extends StatelessWidget {
  const EditProfileAccountInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: UserController(),
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextFieldTitle(
                        title: "frist Name",
                        textOpacity: 0.8,
                      ),
                      CustomTextField(
                        isEnabled: controller.isEnabledForEdit,
                        hintText: Strings.enterYourName.tr,
                        inputType: TextInputType.name,
                        prefixIcon: Images.person,
                        controller: controller.fristNameController,
                        inputAction: TextInputAction.next,
                      ),
                      const TextFieldTitle(
                        title: "last name",
                        textOpacity: 0.8,
                      ),
                      CustomTextField(
                        hintText: Strings.enterYourName.tr,
                        inputType: TextInputType.name,
                        isEnabled: controller.isEnabledForEdit,
                        prefixIcon: Images.person,
                        controller: controller.lastNameController,
                        inputAction: TextInputAction.next,
                      ),
                      TextFieldTitle(
                        title: Strings.phone.tr,
                      ),
                      CustomTextField(
                        isEnabled: false,
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
                        controller: controller.emailController,
                        inputAction: TextInputAction.next,
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
                        controller: controller.addressController,
                        inputAction: TextInputAction.next,
                      ),
                    ]),
              )),
              const SizedBox(height: 30),
              CustomButton(
                radius: 50,
                buttonText: Strings.updateProfile.tr,
                onPressed: () {},
              )
            ],
          );
        });
  }
}
