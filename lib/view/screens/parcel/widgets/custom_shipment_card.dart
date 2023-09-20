

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../widgets/custom_button.dart';

class CustomShipmentCard extends StatelessWidget {
  String desc;
  String leftButtonText;
  String rightButtonText;
    CustomShipmentCard({
    super.key,


    required   this.leftButtonText,
    required   this.rightButtonText,
    required  this. desc,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: K.fixedPadding1,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                backgroundColor: Color(0xffFAFAFA),
                isLoading: false,
                textColor: Theme.of(Get.context!).primaryColor,
                height: Dimensions.paddingSizeSignUp,
                 buttonText: leftButtonText,
                icon: Icons.electric_car,
                iconColor: Theme.of(Get.context!).primaryColor,
                width: Dimensions.identityImageWidth,
                onPressed: () {},
                radius: 50,
              ),
              CustomButton(
                backgroundColor: K.lightGreen2,
                isLoading: false,
                textColor: Theme.of(Get.context!).primaryColor,
                height: Dimensions.paddingSizeSignUp,
                buttonText:rightButtonText,
                // buttonText: ' \$222',//$
                width: Dimensions.identityImageHeight,
                onPressed: () {},
                radius: 50,
              ),
            ],
          ),
          Text( desc,
             // 'Luctus nam arcu est venenatis semper velit. Lectus enim ut tristique nunc. Luctus nam arcu est venenatis semper velit. Lectus enim ut tristique nunc. ',
            style: K.semiBoldBlackTextStyle,
          )
        ],
      ),
    );
  }
}