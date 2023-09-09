import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';

import 'dimensions.dart';

class K {
  ///primary color text (green)

  static TextStyle primaryMediumTextStyle = textBold.copyWith(
      color: Theme.of(Get.context!).primaryColor,
      fontSize: Dimensions.fontSizeLarge);

  static TextStyle primarySmallTextStyle = textRegular.copyWith(
    fontSize: Dimensions.fontSizeSmall,
    color: Theme.of(Get.context!).primaryColor,
  );
  static TextStyle primaryWithUnderLineSmallTextStyle = textMedium.copyWith(
    decoration: TextDecoration.underline,
    color: Theme.of(Get.context!).primaryColor,
    fontSize: Dimensions.fontSizeSmall,
  );
  ///hint color text (grey)
  static TextStyle hintMediumTextStyle = textMedium.copyWith(
      color: Theme.of(Get.context!).hintColor,
      fontSize: Dimensions.fontSizeDefault);
  static TextStyle hintSmallTextStyle = textMedium.copyWith(
    fontSize: Dimensions.fontSizeSmall,
    color: Theme.of(Get.context!).hintColor,

  );  static TextStyle greyMediumTextStyle = textMedium.copyWith(color: Theme.of(Get.context!).textTheme.bodyMedium!.color!.withOpacity(.6));

static EdgeInsets  fixedPadding0= const EdgeInsets.all(Dimensions.paddingSizeLarge);
static SizedBox sizedBoxH0= const SizedBox(height: Dimensions.paddingSizeDefault,);
static SizedBox sizedBoxH1= const SizedBox(height: Dimensions.paddingSizeLarge);
static SizedBox sizedBoxH2= const SizedBox(height: Dimensions.paddingSizeSmall,);
static SizedBox sizedBoxH3= const SizedBox(height: Dimensions.paddingSizeExtraSmall);
static SizedBox sizedBoxW0= const SizedBox(width: Dimensions.paddingSizeDefault,);
}
