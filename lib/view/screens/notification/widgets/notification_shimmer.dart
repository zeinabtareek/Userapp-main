import 'package:flutter/material.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';

import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';
import 'package:shimmer/shimmer.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, item) => Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[50]!,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.07),
            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
          ),
          padding:  const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeLarge,
          ),
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    const CustomImage(
                      image: '',
                      radius: Dimensions.radiusDefault,
                      height: 35, width: 35,
                      placeholder: Images.carPlaceholder,
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall,),

                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Container(width: 40, height: 15, color: Colors.white,),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


                        Container(width: 80, height: 10, color: Colors.white,),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                child: Row(
                  children: [
                    Container(height: 10, color: Colors.white,width: 40,),
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
          ),
        ),
      ),
    );
  }
}
