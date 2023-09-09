import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
import 'package:ride_sharing_user_app/view/screens/auth/model/sign_up_body.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/test_field_title.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';

class AdditionalSignUpScreen extends StatelessWidget {
  const AdditionalSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: GetBuilder<AuthController>(builder: (authController){
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset(Images.logo, width: 120,)),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,Dimensions.paddingSizeSignUp,0,Dimensions.paddingSizeSmall),
                    child: Text(Strings.signUpSuccessful.tr,
                        style: K.primaryMediumTextStyle),

                  ),
                  Text(Strings.additionalSignUpMessage.tr,    style: K.hintMediumTextStyle),
                  const SizedBox(height: Dimensions.paddingSizeLarge,),

                  GestureDetector(
                    onTap: (){
                      authController.pickImage(false, true);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                      child: Container(
                        height: 90,
                        width: Get.width,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1
                            )
                        ),
                        child: Center(
                          child: Stack(alignment: AlignmentDirectional.center,
                            clipBehavior: Clip.none,
                            children: [
                              authController.pickedProfileFile==null?
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: const CustomImage(
                                  image: '',
                                  height: 86,
                                  width: 86,
                                  placeholder: Images.personPlaceholder,
                                ),
                              )
                                  :CircleAvatar(radius: 40, backgroundImage:FileImage(File(authController.pickedProfileFile!.path))),

                              Positioned(
                                  right: 5,
                                  bottom: -3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: const Icon(Icons.camera_enhance_rounded, color: Colors.white,size: 13,
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  TextFieldTitle(title:Strings.email.tr,),
                  CustomTextField(
                    hintText: Strings.email.tr,
                    inputType: TextInputType.emailAddress,
                    prefixIcon: Images.email,
                    controller: authController.emailController,
                    focusNode: authController.emailNode,
                    nextFocus: authController.addressNode,
                    inputAction: TextInputAction.next,

                  ),

                  TextFieldTitle(title: Strings.address.tr,),
                  CustomTextField(
                    hintText: Strings.address.tr,
                    inputType: TextInputType.text,
                    prefixIcon: Images.location,
                    controller: authController.addressController,
                    focusNode: authController.addressNode,
                    nextFocus: authController.identityNumberNode,
                    inputAction: TextInputAction.next,
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


                  CustomButton(
                    buttonText: Strings.send.tr,
                    onPressed: (){
                      // String email = authController.emailController.text;
                      // String address = authController.addressController.text;
                      // String identityNumber = authController.identityNumberController.text;
                      //
                      //
                      // if(authController.pickedProfileFile == null){
                      //   showCustomSnackBar('profile_image_is_required'.tr);
                      // }else if(email.isEmpty){
                      //   showCustomSnackBar('email_is_required'.tr);
                      // }else if (!GetUtils.isEmail(email)) {
                      //   showCustomSnackBar('enter_valid_email_address'.tr);
                      // }else if(address.isEmpty){
                      //   showCustomSnackBar('address_is_required'.tr);
                      // }else if(identityNumber.isEmpty){
                      //   showCustomSnackBar('identity_number_is_required'.tr);
                      // }
                      // else if(authController.pickedIdentityImageFront == null){
                      //   showCustomSnackBar('identity_image_front_is_required'.tr);
                      // }
                      // else if(authController.pickedIdentityImageBack == null){
                      //   showCustomSnackBar('identity_image_back_is_required'.tr);
                      // }
                      // else{
                      //   SignUpBody signUpBody = SignUpBody(
                      //     email: email,
                      //     address: address,
                      //     identityNumber: identityNumber,
                      //
                      //   );
                      //    authController.register(signUpBody);
                        Get.off(()=>   DashboardScreen());
                    //   }
                    },
                    radius: 50,
                  ),

                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Strings.notEnoughTime.tr ,
                        style: textMedium.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).hintColor,
                        ),
                      ),

                      TextButton(
                        onPressed: (){
                          Get.to(()=>  DashboardScreen());
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50,30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,

                        ),
                        child: Text(Strings.addLater.tr, style: textMedium.copyWith(
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
        );
      }),
    );
  }
}
