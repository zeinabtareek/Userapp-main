import 'package:flutter/material.dart';

import '../../../../../pagination/widgets/paginations_widgets.dart';
import '../../../history/model/history_model.dart';
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

class TrackOrderWithStatus extends PaginationViewItem<HistoryData> {
  const TrackOrderWithStatus({super.key, 
    required super.data,
  });

  // final Function() onClickOnState;
  // final Function() onCardPress;
  // final String stateText;
  // final String title;
  // final String subTitle;
  // final bool isReturned;
  // final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // GestureDetector(
        //   onTap: onCardPress,
        //   child: Card(
        //     color: Colors.white,
        //     elevation: 0,
        //     shadowColor: Colors.white10,
        //     shape: RoundedRectangleBorder(
        //       borderRadius:
        //           BorderRadius.circular(Dimensions.paddingSizeDefault),
        //     ),
        //     child: ListTile(
        //       trailing: IconButton(
        //         icon: const Icon(
        //           Icons.more_horiz,
        //           color: Colors.black,
        //         ),
        //         onPressed: () {},
        //       ),
        //       title: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             // TODO: pacge name
        //             // title ??
        //              '',
        //             style: const TextStyle(
        //                 color: Colors.black,
        //                 fontSize: Dimensions.iconSizeSmall),
        //           ),
        //           Text(
        //            data.orderNum!,
        //             style: TextStyle(
        //                 color: Colors.grey, fontSize: Dimensions.fontSizeSmall),
        //           ),
        //         ],
        //       ),
        //       leading: customOval(
        //         Image.asset(Images.package2),
        //         color: Colors.grey.withOpacity(.3),
        //       ),
        //     ),
        //   ),
        // ),
        // Row(
        //   children: [
        //     K.sizedBoxW0,
        //     Text(
        //       Strings.statusOrder.tr,
        //       style: K.hintMediumTextStyle,
        //     ),
        //     K.sizedBoxW0,
        //     Text(
        //     data.status!,
        //       style: K.hintMediumTextStyle.copyWith(
        //         color: isReturned != true
        //             ? Theme.of(context).primaryColor
        //             : Colors.white,
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
