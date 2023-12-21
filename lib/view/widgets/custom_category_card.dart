import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../util/dimensions.dart';
import '../../util/text_style.dart';

class CustomCategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isClicked;
  final bool isComingSoon;
  final Color? color;
  final double? height;
  final double? width;
  const CustomCategoryCard({
    super.key,
    required this.image,
    required this.title,
    this.color,
    this.width,
    this.height,
    this.isComingSoon = false,
    required this.isClicked,
  });

  @override
  Widget build(BuildContext context) {
    if (isComingSoon) {
      return GestureDetector(
        onTap: () {},
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            _Child(
              height: height,
              width: width,
              isClicked: isClicked,
              color: color,
              image: image,
              title: title,
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.7),
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault)),
                child: Center(
                  child: Text(
                    "coming_soon".tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return _Child(
        height: height,
        width: width,
        isClicked: isClicked,
        color: color,
        image: image,
        title: title);
  }
}

class _Child extends StatelessWidget {
  const _Child({
    required this.height,
    required this.width,
    required this.isClicked,
    required this.color,
    required this.image,
    required this.title,
  });

  final double? height;
  final double? width;
  final bool isClicked;
  final Color? color;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? 100,
        width: width ?? 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                color: isClicked
                    ? Theme.of(context).primaryColor
                    : color ?? Theme.of(context).hintColor.withOpacity(0.1),
              ),
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraSmall,
            ),
            Text(
              title,
              style: textSemiBold.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .color!
                      .withOpacity(0.8),
                  fontSize: Dimensions.fontSizeSmall),
            )
          ],
        ));
  }
}
