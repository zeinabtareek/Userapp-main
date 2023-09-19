import 'package:flutter/cupertino.dart';

import '../../../../../util/app_style.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/images.dart';

trackDataListTile({subTitle, title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: K.semiBoldBlackTextStyle),
      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Images.timer,
            width: Dimensions.fontSizeExtraLarge,
          ),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(
            subTitle,
            style: K.hintMediumTextStyle,
          ),
        ],
      ),
      K.sizedBoxH0,
    ],
  );
}
