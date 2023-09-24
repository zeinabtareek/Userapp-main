import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

class CouponUserResultDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final String icon;
  final Function()? onTap;
  const CouponUserResultDialog({Key? key, this.title, this.description, required this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
        
      ),child: Column(mainAxisSize: MainAxisSize.min,children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraLarge, top: Dimensions.paddingSizeOverLarge),
          child:    Image.asset(icon,fit: BoxFit.fill,height: 60, ),
        ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        child: Text(title!.tr, style: textMedium.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color),),
      ),
      description != null?
      Text(description!):const SizedBox(),
      
      Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraLarge),
        child: SizedBox(width: 80,child: CustomButton(buttonText: 'ok'.tr,
            radius: 50,height: 35,
            onPressed: onTap)),
      )
    ],),
    );
  }
}
