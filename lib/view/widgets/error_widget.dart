
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

import '../../util/app_strings.dart';
import '../../util/app_style.dart';
import '../../util/images.dart';

Widget errorWidget({required Function()? onPressed}){
  return Column(

    children: [
      K.sizedBoxH0,
      K.sizedBoxH0,
      K.sizedBoxH0,
      K.sizedBoxH0,

      Image.asset(Images.error,
        width: Dimensions.identityImageWidth, // Set the desired width
        height:  Dimensions.identityImageWidth, // Set the desired height
      ),
      K.sizedBoxH0,
      K.sizedBoxH0,
      Text(Strings.somethingWrong.tr,style: K.blackTextStyleLarge,),
    K.sizedBoxH0,
    K.sizedBoxH0,
    CustomButton(
      onPressed: onPressed,
        radius: Dimensions.radiusExtraLarge,
        buttonText: Strings.tryAgain.tr,width: Dimensions.rewardImageSizeOfferPage,

        image:Image.asset(Images.reloadIcon,width: Dimensions.iconSizeExtraLarge,color: Colors.white,),

    backgroundColor: Theme.of(Get.context!).primaryColor,),
    ],
  );
}