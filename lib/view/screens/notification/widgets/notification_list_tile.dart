import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/custom_image.dart';

class NotificationListTile extends StatelessWidget {
  final String title;
  final String desc;
  final String timer;
  final String image;
  const NotificationListTile(
      {super.key,
      required this.title,
      required this.desc,
      required this.timer,
      required this.image});

  @override
  Widget build(BuildContext context) {
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //
    //
    //
    //     IntrinsicHeight(
    //       child: Wrap(
    //         children: [
    //           CustomImage(
    //             image: image,
    //             radius: Dimensions.radiusDefault,
    //             height: 35,
    //             // width: 35,
    //             placeholder: Images.carPlaceholder,
    //           ),
    //             SizedBox(
    //             width: Dimensions.paddingSizeSmall.w,
    //           ),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 child: Text(
    //                   title,
    //                   style:
    //                       textBold.copyWith(fontSize: Dimensions.fontSizeSmall),
    //                   overflow: TextOverflow.ellipsis,maxLines: 5,
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: MediaQuery.of(context).size.width/2.w,
    //                 child:
    //               //
    //                 Text(
    //                 desc*2,  maxLines: 5,
    //                   softWrap: false,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(
    //           vertical: Dimensions.paddingSizeExtraSmall),
    //       child: Row(
    //         children: [
    //           Text(
    //             timer,
    //           ),
    //           const SizedBox(
    //             width: Dimensions.paddingSizeExtraSmall,
    //           ),
    //           Icon(
    //             Icons.alarm,
    //             size: Dimensions.fontSizeLarge,
    //             color: Theme.of(context).hintColor.withOpacity(0.5),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    CustomImage(
      image: image,
      radius: Dimensions.radiusDefault,
      height: 35,
      // width: 35,
      placeholder: Images.carPlaceholder,
    ),
    K.sizedBoxW0,
    Expanded(
      child: SizedBox(
        // height: 100,
        width: MediaQuery.of(context).size.width/5.w,
        child:  Text(
        title,
        style:
        textBold.copyWith(fontSize: Dimensions.fontSizeSmall),
        overflow: TextOverflow.ellipsis,maxLines: 5,
        // textAlign: TextAlign.start,
      ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(
        children: [
          Text(
            timer,
          ),
          const SizedBox(
            width: Dimensions.paddingSizeExtraSmall,
          ),
          Icon(
            Icons.alarm,
            size: Dimensions.fontSizeLarge,
            color: Theme.of(context).hintColor.withOpacity(0.5),
          ),
        ],
      ),
    ),
  ],
),

        IntrinsicHeight(
          child:
                  SizedBox(

                    child:

                    Text(
                    desc*2,  maxLines: 5,
                      softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  ),
              ),
      ],
    );
  }
}
