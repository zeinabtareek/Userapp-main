
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/payment/controller/payment_controller.dart';

class PaymentTypeItem extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;

  const PaymentTypeItem({Key? key, required this.title, required this.index, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
        builder: (paymentController) {
          return GestureDetector(
            onTap: ()=> paymentController.setPaymentType(index),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,),
              child: Row(mainAxisAlignment : MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Container(width: 20,height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeThree),
                        color: index == selectedIndex? Theme.of(context).primaryColor: null,
                        border: Border.all(width: 2, color: index == selectedIndex? Theme.of(context).primaryColor : Theme.of(context).hintColor)
                    ),
                    child:  Center(child: Icon(Icons.check,
                      size: Dimensions.iconSizeSmall,
                      color: index == selectedIndex? Colors.white: Theme.of(context).canvasColor,
                    )),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault),
                  Text(title.tr, style: index == selectedIndex
                      ? textMedium.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color)
                      :textRegular.copyWith(color: Theme.of(context).hintColor),)
                ],),


              ],),
            ),
          );
        }
    );
  }
}