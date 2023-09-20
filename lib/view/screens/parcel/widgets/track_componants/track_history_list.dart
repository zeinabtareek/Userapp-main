import 'package:flutter/cupertino.dart';

import '../../../../widgets/animated_widget.dart';
import '../item_track_history_card.dart';

Widget trackHistoryList(List list) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return animatedWidget(
            widget: itemTrackHistory(
                title: 'Nintendo Swich Oled',
                subTitle: 'Order ID: JB39029910020', onTap: () {  }),
            limit: list.length);
      });
}
