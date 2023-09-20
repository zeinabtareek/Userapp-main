import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/checked_icon.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/item_track_history_card.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/order_status_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/track_column.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/track_data_column.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/track_data_list_tile.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/track_order_with_status.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/text_style.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/stepper.dart';
import 'live_tracking_screen.dart';

class DeliveryStatusScreen extends StatelessWidget {
  const DeliveryStatusScreen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBody(
      appBar: CustomAppBar(
        title: Strings.deliveryStatus.tr,
        showBackButton: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: K.fixedPadding0,
          child: Column(
            children: [
              K.sizedBoxH2,
              Text(Strings.estimatedDeliveryDate.tr,
                  style: textBold.copyWith(
                    fontSize: Dimensions.fontSizeExtraLarge,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )),
              Text(
                '6:30 pm • Feb 2th 2023',
                style: K.hintMediumTextStyle,
              ),
              K.sizedBoxH2,
              K.sizedBoxH2,
              K.sizedBoxH2,
              itemTrackHistory(
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.black,
                  ),
                  title: 'New York, NY, 10016, USA',
                  subTitle: 'Order ID: JB390299191242',
                  elevated: 0, onTap: () {  }),
              K.sizedBoxH2,

              orderStatusWidget(() {},
                  isReturned: false, text: 'In Delivery Courier', width: 200),
              K.sizedBoxH2,
              K.sizedBoxH2,
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      K.sizedBoxW0,
                      K.sizedBoxW0,
                      trackColumn(status),
                      K.sizedBoxW0,
                      K.sizedBoxW0,
                      Expanded(
                          child: trackDataColumn(
                        x: status,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  Center(
                    child: trackDataListTile(
                      title: 'Arrived at the Destination',
                      subTitle: status[1]['subTitle'],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: K.fixedPadding0,
                child: CustomButton(
                  backgroundColor: Colors.white,
                  borderColor: Theme.of(Get.context!).primaryColor,
                  isLoading: false,
                  showBorder: true,
                  textColor: Theme.of(Get.context!).primaryColor,
                  height: 35,
                  buttonText: Strings.liveTracking.tr,
                  width: Get.width,
                  onPressed: () {
                    Get.to(LiveTrackingScreenForParcel());
                  },
                  radius: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

List status = [
  {
    'title': 'Request Accepted',
    'subTitle': '10:00 am • Feb 2th 2023',
  },
  {
    'title': 'Parcel Picked',
    'subTitle': '10:00 am • Feb 2th 2023',
  },
  {
    'title': 'Drop Point',
    'subTitle': '10:00 am • Feb 2th 2023',
  },
  {
    'title': 'Request Accepted',
    'subTitle': '10:00 am • Feb 2th 2023',
  },
  {
    'title': 'Delivered at Address',
    'subTitle': '10:00 am • Feb 2th 2023',
  },
  {
    'title': 'Request Accepted',
    'subTitle': '10:00 am • Feb 2th 2023',
  },
];
