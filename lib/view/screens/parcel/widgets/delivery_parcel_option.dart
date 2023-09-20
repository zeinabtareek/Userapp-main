


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../util/dimensions.dart';
import '../../../widgets/custom_button.dart';

class DeliveryParcelOptions extends StatelessWidget {
  double? height;
  bool isTapped;
  int isSelected; // Add this property
  Function(int)? onPressed; // Update the type of onPressed
  DeliveryParcelOptions(
      {Key? key,
        this.height,
        this.onPressed,
        required this.isTapped,
        required this.isSelected}) // Update the constructor
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height ?? 88,
      decoration: BoxDecoration(
          color: Color(0xffFAFAFA), borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: List.generate(listOfOptions.length, (index) {
          final isSelectedButton =
              index == isSelected; // Check if the button is selected
          return Expanded(
            child: Padding(
              padding: index != 0
                  ?   EdgeInsets.only(left: Dimensions.iconSizeSmall)
                  : EdgeInsets.only(right: 0),
              child: CustomButton(
                radius: 50,
                textColor: isSelectedButton
                    ? Theme.of(context).cardColor
                    : Theme.of(context).hintColor,
                backgroundColor: isSelectedButton
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                // Update the background color based on isSelectedButton
                buttonText: listOfOptions[index],
                onPressed: () => onPressed!(
                    index), // Pass the selected button index to the onPressed callback
              ),
            ),
          );
        }),
      ),
    );
  }
}

List listOfOptions = ['Standard', 'Regular', 'Express'];