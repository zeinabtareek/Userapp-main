import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../parcel_screen.dart';
import '../item_track_history_card.dart';
import 'order_status_widget.dart';

Widget trackOrderWithStatus({onpressed, text, isReturned}) {
  return Column(
    children: [
      itemTrackHistory(
          icon: const Icon(
            Icons.more_horiz,
            color: Colors.black,
          ),
          title: 'New York, NY, 10016, USA',
          subTitle: 'Order ID: JB390299191242',
          elevated: 0),
      orderStatusWidget(onpressed, isReturned: isReturned, text: text),
    ],
  );
}
