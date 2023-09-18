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

    return GetBuilder<UserController>(builder: (userController) {
      return Column(
        children: [
          Expanded(child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextFieldTitle(title: Strings.name.tr, textOpacity: 0.8,),

              CustomTextField(
                hintText: Strings.enterYourName.tr,
                inputType: TextInputType.name,
                prefixIcon: Images.person,
                inputAction: TextInputAction.next,
              ),


              TextFieldTitle(
                title: Strings.phone.tr,
              ),
              CustomTextField(
                hintText: Strings.enterYourPhoneNumber.tr,
                inputType: TextInputType.number,
                countryDialCode: userController.defaultDailCode,
                inputAction: TextInputAction.next,
              ),
              TextFieldTitle(title: Strings.email.tr, textOpacity: 0.8,),

              CustomTextField(
                hintText: Strings.enterYourEmail.tr,
                inputType: TextInputType.emailAddress,
                prefixIcon: Images.email,
                inputAction: TextInputAction.next,
              ),  TextFieldTitle(title: Strings.address.tr, textOpacity: 0.8,),

              CustomTextField(
                hintText: Strings.enterYourAddress.tr,
                inputType: TextInputType.text,
                prefixIcon: Images.location,
                inputAction: TextInputAction.next,
              ),


            ]),
          )),

          const SizedBox(height: 30),
          CustomButton(  radius: 50,
            buttonText: Strings.updateProfile.tr,
            onPressed: () => Get.back(),
          )
        ],
      );
    }
    );
  }
}