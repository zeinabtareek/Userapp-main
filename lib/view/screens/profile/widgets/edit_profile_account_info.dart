import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

import '../../../../authenticate/presentation/widgets/test_field_title.dart';
import '../../../../util/app_strings.dart';

class EditProfileAccountInfo extends StatelessWidget {
  const EditProfileAccountInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            TextFieldTitle(title: Strings.name.tr,textOpacity: 0.8,),
            CustomTextField(
                prefixIcon: Images.editProfileName,
                borderRadius: 10,
                showBorder: false,
                hintText: Strings.enterYourName.tr,
                fillColor: Theme.of(context).primaryColor.withOpacity(0.04)
            ),

            TextFieldTitle(title: Strings.profile.tr,textOpacity: 0.8,),
            CustomTextField(
                prefixIcon: Images.editProfilePhone,
                borderRadius: 10,
                showBorder: false,
                hintText: Strings.enterYourPhoneNumber.tr,
                fillColor: Theme.of(context).primaryColor.withOpacity(0.04)
            ),

            TextFieldTitle(title: Strings.email.tr,textOpacity: 0.8,),
            CustomTextField(
                prefixIcon: Images.editProfileEmail,
                borderRadius: 10,
                showBorder: false,
                hintText: Strings.enterYourEmail.tr,
                fillColor: Theme.of(context).primaryColor.withOpacity(0.04)
            ),

            TextFieldTitle(title: Strings.address.tr,textOpacity: 0.8,),
            CustomTextField(
                prefixIcon: Images.editProfileLocation,
                borderRadius: 10,
                showBorder: false,
                hintText: Strings.enterYourAddress.tr,
                fillColor: Theme.of(context).primaryColor.withOpacity(0.04)
            ),
          ]),
        )),

        const SizedBox(height:30),
        CustomButton (
          buttonText:Strings.updateProfile.tr,
          onPressed: ()=> Get.back(),
        )
      ],
    );
  }
}