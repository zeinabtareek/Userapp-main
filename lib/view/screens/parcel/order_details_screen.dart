import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/item_track_history_card.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/order_status_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/track_column.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/track_data_column.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/track_data_list_tile.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../widgets/animated_widget.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_button.dart';
import 'delivery_staus_screen.dart';
import 'live_tracking_screen.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // // backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     color: Colors.white,
      //     onPressed: () {},
      //   ),
      // ),
      body:    CustomBody(
        appBar: CustomAppBar(
          title: Strings.checkRates.tr,
          showBackButton: true,
          centerTitle: true,
        ),
        body:  SingleChildScrollView(
                child: Padding(
                  padding: K.fixedPadding0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        K.sizedBoxH0,
                        itemTrackHistory(
                            onTap: () {},
                            icon: const Icon(
                              Icons.more_horiz,
                            ),
                            title: 'Nintendo Swich Oled',
                            subTitle: 'Order ID: JB39029910020'),
                        K.sizedBoxH0,



                        orderStatusWidget(() {},
                            isReturned: false, text: 'In Delivery ', width: 200),
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
                        K.sizedBoxH0,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.resentSearch.tr,
                              style: K.semiBoldBlackTextStyle,
                            ),
                          ],
                        ),
                        K.sizedBoxH0,
                        animatedWidget(
                            widget:  itemTrackHistory(onTap: (){
                              Get.to(()=>OrderDetails());},
                                title: 'Nintendo Swich Oled',
                                subTitle: 'Order ID: JB39029910020'),


                            limit: 4),
                      ]),
                ),
              )),

     );
  }
}
