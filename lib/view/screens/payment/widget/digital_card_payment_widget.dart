
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/payment/controller/payment_controller.dart';
import 'package:ride_sharing_user_app/view/screens/payment/widget/digital_payment_model.dart';

import '../credit_card_screen.dart';

class DigitalCardPaymentWidget extends StatelessWidget {
  final DigitalPaymentModel digitalPaymentModel;
  final int index;
  const DigitalCardPaymentWidget({Key? key, required this.digitalPaymentModel, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.find<PaymentController>().setDigitalPaymentType(index);
        Get.to(()=>CreditCardScreen());
        ///f

      },
      child: Padding(
        padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
        child: Container(width: 200,decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          color: digitalPaymentModel.color!.withOpacity(.125),
        ),child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text(digitalPaymentModel.name!.tr,style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color)),
                digitalPaymentModel.isSelected?
                const Icon(Icons.check_circle, color: Colors.green,):Stack()
              ],),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Text('**** **** **** ** ${digitalPaymentModel.cardNumber!.substring(digitalPaymentModel.cardNumber!.length-3,digitalPaymentModel.cardNumber!.length)}',
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyMedium!.color)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                child: Text('tap_to_add_your_credit_card'.tr, style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color,fontSize: 12,) ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
              //   child: Text(digitalPaymentModel.expireDate!, style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color),),
              // ),
              SizedBox(
                  width: Dimensions.iconSizeLarge,
                  height: Dimensions.iconSizeLarge,
                  child: Image.asset(digitalPaymentModel.icon!))
            ],
          ),
        ),),
      ),
    );
  }
}