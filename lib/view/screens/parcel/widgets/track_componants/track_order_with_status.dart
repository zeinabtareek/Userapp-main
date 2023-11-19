import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../util/app_strings.dart';
import '../../../../../util/app_style.dart';
import '../../../../../util/dimensions.dart';
import '../../../../../util/images.dart';
import '../../../../widgets/custom_button.dart';
import '../../screens/parcel_screen.dart';
import '../custom_oval.dart';
import '../item_track_history_card.dart';
import 'order_status_widget.dart';

Widget trackOrderWithStatus({onPressed, text, isReturned}) {
  return Column(
    children: [
      itemTrackHistory(
          icon: const Icon(
            Icons.more_horiz,
            color: Colors.black,
          ),
          title: 'New York, NY, 10016, USA',
          subTitle: 'Order ID: JB390299191242',
          elevated: 0,
          onTap: () {}),
      orderStatusWidget(onPressed, isReturned: isReturned, text: text),
    ],
  );
}

class TrackOrderWithStatus extends StatelessWidget {
  final Function() onClickOnState;
  final Function() onCardPress;
  final String stateText;
  final String title;
  final String subTitle;
  final bool isReturned;
  final double? width;
  const TrackOrderWithStatus({
    super.key,
    required this.stateText,
    required this.onClickOnState,
    required this.onCardPress,
    required this.subTitle,
    required this.title,
    required this.isReturned,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onCardPress,
          child: Card(
            color: Colors.white,
            elevation: 0,
            shadowColor: Colors.white10,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Dimensions.paddingSizeDefault),
            ),
            child: ListTile(
              trailing: IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.iconSizeSmall),
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
        ),
        GestureDetector(
          onTap: onClickOnState,
          child: Row(
            children: [
              K.sizedBoxW0,
              Text(
                Strings.statusOrder.tr,
                style: K.hintMediumTextStyle,
              ),
              K.sizedBoxW0,
              CustomButton(
                backgroundColor: isReturned == true ? Colors.red : K.lightGreen,
                isLoading: false,
                textColor: isReturned != true
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                height: 30,
                buttonText: stateText,
                width: width ?? 88,
                onPressed: onClickOnState,
                radius: 50,
              ),
            ],
          ),
        )
      ],
    );
  }
}
