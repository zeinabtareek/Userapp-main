import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';

import '../../../helper/custom_pick_helper.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/text_style.dart';
import '../../../view/screens/dashboard/dashboard_screen.dart';
import '../../../view/widgets/custom_button.dart';
import '../../../view/widgets/custom_image.dart';
import '../../../view/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';
import '../widgets/test_field_title.dart';

class CompleteDataScreen extends GetView<AuthController> {
  const CompleteDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image.asset(
                  Images.logo,
                  width: 120,
                )),

                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      0,
                      Dimensions.paddingSizeSignUp,
                      0,
                      Dimensions.paddingSizeSmall),
                  child: Text(Strings.signUpSuccessful.tr,
                      style: K.primaryMediumTextStyle),
                ),
                Text(Strings.additionalSignUpMessage.tr,
                    style: K.hintMediumTextStyle),
                const SizedBox(
                  height: Dimensions.paddingSizeLarge,
                ),

                GestureDetector(
                  onTap: () async {
                    CustomPickHelper.pickImage(ImageSource.camera)
                        .then((value) => {
                              if (value != null)
                                {
                                  controller.pickedProfileFile = value,
                                }
                            });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                    child: Container(
                      height: 90,
                      width: Get.width,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 1)),
                      child: Obx(
                        () => Center(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            clipBehavior: Clip.none,
                            children: [
                              controller.getPickedProfileFile.value == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: const CustomImage(
                                        image: '',
                                        height: 86,
                                        width: 86,
                                        placeholder: Images.personPlaceholder,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 40,
                                      backgroundImage: FileImage(File(controller
                                          .getPickedProfileFile.value!.path))),
                              Positioned(
                                  right: 5,
                                  bottom: -3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle),
                                    padding: const EdgeInsets.all(5),
                                    child: const Icon(
                                      Icons.camera_enhance_rounded,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                TextFieldTitle(
                  title: Strings.email.tr,
                ),
                CustomTextField(
                  hintText: Strings.email.tr,
                  inputType: TextInputType.emailAddress,
                  prefixIcon: Images.email,
                  controller: controller.completeEmailController,
                  focusNode: controller.completeEmailFocusNode,
                  nextFocus: controller.completeAddressFocusNode,
                  inputAction: TextInputAction.next,
                ),

                TextFieldTitle(
                  title: Strings.address.tr,
                ),
                CustomTextField(
                  hintText: Strings.address.tr,
                  inputType: TextInputType.text,
                  prefixIcon: Images.location,
                  controller: controller.addressCompleteController,
                  focusNode: controller.completeAddressFocusNode,
                  // nextFocus: authController.identityNumberNode,
                  inputAction: TextInputAction.done,
                ),
                K.sizedBoxH0,
                K.sizedBoxH0,
                // TextFieldTitle(title: 'identification_number'.tr,),
                // CustomTextField(
                //   hintText: 'Ex: 12345',
                //   inputType: TextInputType.text,
                //   prefixIcon: Images.identity,
                //   controller: authController.identityNumberController,
                //   focusNode: authController.identityNumberNode,
                //   inputAction: TextInputAction.done,
                // ),
                //
                //
                //
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                //   child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                //     GestureDetector(
                //       onTap: ()=> authController.pickImage(false, false),
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
                //               child: authController.pickedIdentityImageFront != null ?  Image.file(File(authController.pickedIdentityImageFront!.path),
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
                //     const SizedBox(width: Dimensions.paddingSizeDefault),
                //
                //     GestureDetector(
                //       onTap: ()=> authController.pickImage(true, false),
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
                //               child: authController.pickedIdentityImageBack != null ?  Image.file(File(authController.pickedIdentityImageBack!.path),
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

                Obx(() => CustomButton(
                      buttonText: Strings.send.tr,
                      isLoading: controller.isLoadingCompleteData.value,
                      onPressed: controller.completeData,
                      radius: 50,
                    )),

                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.notEnoughTime.tr,
                      style: textMedium.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => DashboardScreen(),
                            binding: BindingsBuilder(() {
                          Get.lazyPut(() => BaseController());
                        }));
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(Strings.addLater.tr,
                          style: textMedium.copyWith(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeDefault,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
