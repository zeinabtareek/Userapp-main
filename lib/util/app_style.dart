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
    static TextStyle hintLargeTextStyle = textMedium.copyWith(
      color: Theme.of(Get.context!).hintColor,

      fontSize: Dimensions.fontSizeLarge);

  static TextStyle hintSmallTextStyle = textMedium.copyWith(
    fontSize: Dimensions.fontSizeSmall,
    color: Theme.of(Get.context!).hintColor,

  );  static TextStyle greyMediumTextStyle = textMedium.copyWith(color: Theme.of(Get.context!).textTheme.bodyMedium!.color!.withOpacity(.6));

/// black color text
  static TextStyle boldBlackTextStyle =  textBold.copyWith(
  fontSize:Dimensions.fontSizeOverLarge,
  fontWeight:FontWeight.w600,
  color: Colors.black,
  );

///border radius
static BorderRadius  borderRadiusOnlyTop= const  BorderRadius.only(
    topLeft: Radius.circular(Dimensions.paddingSizeSmall),
    topRight: Radius.circular(Dimensions.paddingSizeSmall),
  );

///box decorations
      ///box decoration with border primary color and background white
  static BoxDecoration  boxDecorationWithPrimaryBorder=  BoxDecoration(
  border: Border.all(
  color: Theme.of(Get.context!).primaryColor, width: 1),
  borderRadius:
  BorderRadius.circular(Dimensions.paddingSizeSmall));



static EdgeInsets  fixedPadding0= const EdgeInsets.all(Dimensions.paddingSizeLarge);
static EdgeInsets  fixedPadding1= const EdgeInsets.all(Dimensions.paddingSizeSmall);
static SizedBox sizedBoxH0= const SizedBox(height: Dimensions.paddingSizeDefault,);
static SizedBox sizedBoxH1= const SizedBox(height: Dimensions.paddingSizeLarge);
static SizedBox sizedBoxH2= const SizedBox(height: Dimensions.paddingSizeSmall,);
static SizedBox sizedBoxH3= const SizedBox(height: Dimensions.paddingSizeExtraSmall);
static SizedBox sizedBoxW0= const SizedBox(width: Dimensions.paddingSizeDefault,);
}