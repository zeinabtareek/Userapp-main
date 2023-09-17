


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/custom_image.dart';

class NotificationListTile extends StatelessWidget {
  final String title;
  final String desc;
  final String timer;
  final String image;
  const NotificationListTile({super.key , required this.title, required this.desc, required this.timer, required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
                  CustomImage(
                image: image,
                radius: Dimensions.radiusDefault,
                height: 35, width: 35,
                placeholder: Images.carPlaceholder,
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall,),

              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                  ),

                  Text(desc ),
                ],
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
          child: Row(
            children: [
                Text(timer,      ),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

              Icon(
                Icons.alarm,
                size: Dimensions.fontSizeLarge,
                color: Theme.of(context).hintColor.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
