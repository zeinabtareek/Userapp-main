import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
 import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../profile/profile_screen/controller/user_controller.dart';
import 'custom_card_item.dart';


class BankInfoView extends StatelessWidget {
  const BankInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: Strings.bankInfo.tr),
        body: GetBuilder<UserController>(

            builder: (profileController) {
              String name = 'John Doe';
              String bank = 'MIT Bank USA';
              String branch = 'California';
              String accountNo = 'MIT1234567890';
              return Column(
                children: [
                  GestureDetector(
                   // onTap: ()=> Get.to(()=> const BankInfoEditScreen()),
                    child: Padding(
                      padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text(Strings.editInfo.tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                            color: Get.isDarkMode? Theme.of(context).hintColor: Theme.of(context).primaryColor)),
                        K.sizedBoxH0,
                        SizedBox(width: Dimensions.iconSizeLarge, child: Image.asset(Images.editIcon, color: Get.isDarkMode? Theme.of(context).hintColor: Theme.of(context).primaryColor))
                      ],),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Container(width: Get.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(width: Get.width/3,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor.withOpacity(.05),
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), bottomLeft: Radius.circular(100) )
                                ),

                              ),
                            ),
                          ),
                          Positioned(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(width: Get.width/4,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor.withOpacity(.05),
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), bottomLeft: Radius.circular(100) )
                                ),

                              ),
                            ),
                          ),
                          Column(children: [
                            const SizedBox(height: Dimensions.paddingSizeDefault),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              CardItem(title: 'ac_holder',value: name),
                              Padding(
                                padding:  const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
                                child: SizedBox(width: 50, child: Image.asset(Images.bankInfo)),
                              )
                            ],),
                            Divider(color: Theme.of(context).cardColor.withOpacity(.5),thickness: 1.5),

                            CardItem(title: 'bank', value: bank),
                            CardItem(title: 'branch', value: branch),
                            CardItem(title: 'account_no' ,value: accountNo),
                          K.sizedBoxH0,

                          ],),
                        ],
                      ),),
                  ),
                ],
              );
            }
        ));
  }
}


