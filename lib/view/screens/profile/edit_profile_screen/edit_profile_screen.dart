import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
 import 'package:ride_sharing_user_app/view/screens/profile/widgets/edit_profile_account_info.dart';
import 'package:ride_sharing_user_app/view/screens/profile/widgets/edit_profile_other_info.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../profile_screen/controller/user_controller.dart';
import 'controller/edit_profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with SingleTickerProviderStateMixin{
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar:   const CustomAppBar(title: Strings.makeYourProfileToEarnPoint,showBackButton: true,),
        body: Padding(
          padding: K.fixedPadding0,
          child: Column(children:  [
            GetBuilder<UserController>(builder: (userController){
              return Row(crossAxisAlignment: CrossAxisAlignment.start,children: [

                InkWell(
                  onTap:()=>userController.pickImage(false, true),
                  child:Container(
                    decoration: BoxDecoration(shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).primaryColor,width: 2)
                    ),
                    child: Stack(clipBehavior: Clip.none, children:[
                      userController.pickedProfileFile==null?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: const CustomImage(height: 70, width: 70,
                          image: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                          placeholder: Images.personPlaceholder,
                        ),
                      ):CircleAvatar(radius: 35, backgroundImage:FileImage(File(userController.pickedProfileFile!.path))),

                      Positioned(right: 5, bottom: -3,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.camera_enhance_rounded, color: Colors.white,size: 13,
                          ),
                        )
                      )]
                    ),
                  )
                ),

                K.sizedBoxW0,


                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Text(
                        "Norman Bell",style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                        maxLines: 1, overflow: TextOverflow.ellipsis,),
                    ]),


                    Row(children: [
                      Text('${Strings.goldCustomer.tr} :'.tr,
              style: K.hintSmallTextStyle,),
              // const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                      K.sizedBoxH0,
                      const Icon(Icons.star,size: 12,color: Colors.amber,),
                      ],
                    ),


                      Row(children: [
                        Text('${Strings.yourRating.tr} :'.tr,
              style: K.hintSmallTextStyle,),
                        K.sizedBoxH0,
                        Text('5'.tr,
                        style: K.hintSmallTextStyle,
                        ),
                        const Icon(Icons.star,size: 12,color: Colors.amber,),
                        ],
                      )
                    ],
                  ),
                ),

              ],
              );
            }),
            K.sizedBoxH0,
            K.sizedBoxH0,
            TabBar(
              controller: tabController,
              unselectedLabelColor: Colors.grey,
              labelColor: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
              labelStyle: textSemiBold.copyWith(),
              isScrollable: true,
              indicatorPadding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.all(0),
              tabs:  [
                SizedBox(height: 30,child: Tab(text: Strings.accountInfo.tr)),
                SizedBox(height: 30,child: Tab(text: Strings.otherInfo.tr)),
              ],
            ),K.sizedBoxH0,
            Expanded(
              child: TabBarView(
                controller: tabController,
                children:  const [
                  EditProfileAccountInfo(),
                  EditProfileOtherInfo(),
                ],
              ),
            )],
          ),
        ),
      ),
    );
  }
}




