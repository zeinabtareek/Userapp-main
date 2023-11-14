import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/dimensions.dart';
import '../../../../util/text_style.dart';

class UserTypeButtonWidget extends StatelessWidget {
  final String userType;
  final Function() onTap;
 final bool isSelected;
  const UserTypeButtonWidget({
    Key? key,
    required this.isSelected,
    required this.userType,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraSmall),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            border: Border.all(
                width: .5,
                color: isSelected
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).primaryColor),
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
                // : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(userType.tr,
                    textAlign: TextAlign.center,
                    style: textSemiBold.copyWith(
                        color: isSelected
                            ?Colors.white
                            // : Theme.of(context).colorScheme.onSecondary,
                            : Theme.of(context).shadowColor.withOpacity(.5),
                            // : Theme.of(context).hintColor.withOpacity(.65),
                        fontSize: Dimensions.fontSizeLarge)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
