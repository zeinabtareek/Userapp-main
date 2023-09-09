import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/test_field_title.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../profile_screen/controller/user_controller.dart';

class EditProfileOtherInfo extends StatelessWidget {
  const EditProfileOtherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: Dimensions.paddingSizeSmall,
              ),

              Text(
                Strings.savedAddress.tr,
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .color!
                      .withOpacity(0.8),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall),
                child: TextFieldTitle(title: Strings.home.tr),
              ),
              CustomTextField(
                  prefixIcon: Images.editProfileHome,
                  borderRadius: 10,
                  showBorder: false,
                  hintText: Strings.enterYourAddress.tr,
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.04)),

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall),
                child: TextFieldTitle(title: Strings.office.tr),
              ),
              CustomTextField(
                  prefixIcon: Images.editProfilePhone,
                  borderRadius: 10,
                  showBorder: false,
                  hintText: Strings.enterYourAddress.tr,
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.04)),
              ///removed data
              // TextFieldTitle(title: 'identification_number'.tr,textOpacity: 0.8,),
              // CustomTextField(
              //     prefixIcon: Images.editProfileIdentity,
              //     borderRadius: 10,
              //     showBorder: false,
              //     hintText: 'enter_your_identification_number'.tr,
              //     fillColor: Theme.of(context).primaryColor.withOpacity(0.04)
              // ),

              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              //   child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              //     GestureDetector(
              //       onTap: ()=> userController.pickImage(false, false),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              //         child: Align(alignment: Alignment.center, child:
              //         DottedBorder(
              //           color: Theme.of(context).hintColor,
              //           dashPattern: const [3,4],
              //           borderType: BorderType.RRect,
              //           radius: const Radius.circular(Dimensions.paddingSizeSmall),
              //           child: Stack(children: [
              //             ClipRRect(
              //               borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              //               child: userController.pickedIdentityImageFront != null ?  Image.file(File(userController.pickedIdentityImageFront!.path),
              //                 width: Dimensions.identityImageWidth, height: Dimensions.identityImageHeight, fit: BoxFit.cover,
              //               ) :SizedBox(height: Dimensions.identityImageHeight,
              //                 width: Dimensions.identityImageWidth,
              //                 child: Image.asset(Images.cameraPlaceholder,width: 50),
              //               ),
              //             ),
              //             Positioned(
              //               bottom: 0, right: 0, top: 0, left: 0,
              //               child: InkWell(
              //                 // onTap: () => authProvider.pickImage(true,false, false),
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              //                   ),
              //
              //                 ),
              //               ),
              //             ),
              //           ]),
              //         )),
              //       ),
              //     ),
              //
              //     const SizedBox(width: Dimensions.paddingSizeDefault),
              //
              //     GestureDetector(
              //       onTap: ()=> userController.pickImage(true, false),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              //         child: Align(alignment: Alignment.center, child:
              //         DottedBorder(
              //           color: Theme.of(context).hintColor,
              //           dashPattern: const [3,4],
              //           borderType: BorderType.RRect,
              //           radius: const Radius.circular(Dimensions.paddingSizeSmall),
              //           child: Stack(children: [
              //             ClipRRect(
              //               borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              //               child: userController.pickedIdentityImageBack != null ?  Image.file(File(userController.pickedIdentityImageBack!.path),
              //                 width: Dimensions.identityImageWidth, height: Dimensions.identityImageHeight, fit: BoxFit.cover,
              //               ) :SizedBox(height: Dimensions.identityImageHeight,
              //                 width: Dimensions.identityImageWidth,
              //                 child: Image.asset(Images.cameraPlaceholder,width: 50,),
              //               ),
              //             ),
              //             Positioned(
              //               bottom: 0, right: 0, top: 0, left: 0,
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              //                 ),
              //
              //               ),
              //             ),
              //           ]),
              //         )),
              //       ),
              //     ),
              //   ],),
              // ),
            ]),
          )),
          K.sizedBoxH0,
          CustomButton(
            buttonText: Strings.updateProfile.tr,
            onPressed: () => Get.back(),
          )
        ],
      );
    });
  }
}
