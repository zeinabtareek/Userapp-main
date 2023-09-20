import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import 'custom_oval.dart';

Widget itemTrackHistory(
    {Icon? icon,
    double? elevated,
      required void Function()? onTap,
    required String title,
    required String subTitle}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: Colors.white,
      elevation: elevated ?? 1,
      shadowColor: Colors.white10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
      ),
      child: ListTile(
        trailing: IconButton(
          icon: icon ??
              Icon(
                Icons.arrow_forward_ios_sharp,
                size: 15,
                color: Colors.grey.withOpacity(.7),
              ),
          onPressed: () {},
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: TextStyle(
                  color: Colors.black, fontSize: Dimensions.iconSizeSmall),
            ),
            Text(
              subTitle ?? '',
              style: TextStyle(
                  color: Colors.grey, fontSize: Dimensions.fontSizeSmall),
            ),
          ],
        ),
        leading: CustomOvel(Image.asset(Images.package2),
            color: Colors.grey.withOpacity(.3)),
      ),
    ),
  );
}
