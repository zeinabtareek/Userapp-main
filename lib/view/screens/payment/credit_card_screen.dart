
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';

import '../../../util/dimensions.dart';
import '../../../util/text_style.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import 'controller/payment_controller.dart';

class CreditCardScreen extends StatelessWidget {
    CreditCardScreen({Key? key}) : super(key: key);
final controller =Get.put(PaymentController(paymentRepo: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: 'here_is_your_payment'.tr,onBackPressed: (){
          if(Navigator.canPop(context))
            Get.back();
        },showBackButton: true,),

        body: Padding(
          padding:   EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraLarge),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraLarge),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Text('payment'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
                    // Container(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeThree),
                    //     decoration: BoxDecoration(
                    //       color: Theme.of(context).primaryColor.withOpacity(.2),
                    //   borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    // ),child: Row(children: [
                    //   Text('cash'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
                    //   const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                    //   SizedBox(width: Dimensions.iconSizeSmall, child: Image.asset(Images.cash))
                    // ],))
                  ],),


                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text('add_your_credit_card'.tr),
                  const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                  Text('complete'.tr, style: textSemiBold.copyWith(color: Theme.of(context).primaryColor)),
                ],),
                CreditCard(
                  config: controller.paymentConfig,
                  onPaymentResult: controller.onPaymentResult,
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
