import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../../../widgets/custom_button.dart';


class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBody(
          appBar: CustomAppBar(
            title: Strings.tripDetails.tr,
            showBackButton: false,
            centerTitle: false,
          ),
          body:     Padding(
            padding: K.fixedPadding0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                K.sizedBoxH0,

                Text(Strings.tripDetails.tr,style: K.blackTextStyleLarge,),
                K.sizedBoxH0,
                Text(Strings.tripId.tr+"  : 299929992999",style: K.hintLargeTextStyle,),
                K.sizedBoxH0,
                K.sizedBoxH0,
                Center(child: Image.asset(Images.statusIcon,width: MediaQuery.of(context).size.width/3,)),
                K.sizedBoxH0,
                K.sizedBoxH0,
                Row(    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.totalDistance.tr,style: K.semiBoldBlackTextStyle,), K.sizedBoxH2,
                        Text(Strings.totalPrice.tr,style: K.semiBoldBlackTextStyle,), K.sizedBoxH2,
                        Text(Strings.discount.tr,style: K.primaryMediumTextStyle,), K.sizedBoxH2,
                        Text(Strings.tax.tr,style: K.semiBoldBlackTextStyle,),  K.sizedBoxH2,
                        Text(Strings.yourPriceAfterDiscount.tr,style: K.semiBoldBlackTextStyle,), K.sizedBoxH2,

                      ],
                    ),  Column(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('12 Km',style: K.semiBoldBlackTextStyle,),K.sizedBoxH2,
                        Text('12  ',style: K.semiBoldBlackTextStyle,),K.sizedBoxH2,
                        Text('12  ',style: K.primaryMediumTextStyle,),K.sizedBoxH2,
                        Text('12  ',style: K.semiBoldBlackTextStyle,),K.sizedBoxH2,
                        Text('12223  ',style: K.semiBoldBlackTextStyle,),K.sizedBoxH2,

                      ],
                    ),
                  ],
                ),


                K.sizedBoxH0,
                K.sizedBoxH0,
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(children: [
                    Image.asset(Images.profileMyWallet,height: 15,width: 15,),
                    const SizedBox(width: Dimensions.paddingSizeSmall,),
                    Text(Strings.payment.tr,style: textRegular.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeDefault),),
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('cash'.tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColor),),
                  )]
                ),
                Expanded(child: SizedBox()),
                CustomButton(
                  buttonText: Strings.done.tr,
                  radius: 25,
                  height: 35,
                  onPressed: () {

                    // Get.back();
                  },
                ),

              ],
            ),
          ),
        ) );
  }
}