import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../util/dimensions.dart';
import '../../util/text_style.dart';

class CustomCategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isClicked;

  const CustomCategoryCard({
    super.key,
    required this.image,
    required this.title,
    required this.isClicked,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 100, width: 100,
    child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            color: isClicked?Theme.of(context).primaryColor : Theme.of(context).hintColor.withOpacity(0.1),
          ),
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Image.asset(image),
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
