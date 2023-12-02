import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_oval.dart';
import '../widgets/custom_parcel_body.dart';
import '../widgets/item_track_history_card.dart';
import '../widgets/track_componants/track_history_list.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/images.dart';
import '../../../widgets/animated_widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../../../widgets/custom_text_field.dart';
import 'order_details_screen.dart';

class ParcelTrackingScreen extends StatelessWidget {
  const ParcelTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //       statusBarIconBrightness: Brightness.dark, // dark text for status bar
    //       statusBarColor: Theme.of(context).primaryColor),
    // );
    return Scaffold(
        backgroundColor: Colors.white,
        // backgroundColor: Colors.white,

        body: SafeArea(
          child: CustomBody(
            appBar: CustomAppBar(
              title: Strings.trackYourPackage.tr,
              showBackButton: true,
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: K.fixedPadding0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // K.sizedBoxH0,

                    Row(
                      children: [
                        // K.sizedBoxW0,
                        // K.sizedBoxW0,
                        Expanded(
                          child: CustomTextField(
                            hintText: '',
                            inputType: TextInputType.name,
                            suffixIcon: Images.close,
                            prefixIcon: Images.search,
                            fillColor: K.lightGreen,
                            inputAction: TextInputAction.next,
                          ),
                        ),
                        K.sizedBoxW0,
                        customOval(
                            Image.asset(
                              Images.scanner,
                              color: Colors.white,
                            ),
                            color: Theme.of(context).primaryColor),
                        // K.sizedBoxW0,
                        // K.sizedBoxW0,
                      ],
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
                    // animatedWidget(onTap: (){
                    // // Get.to(CheckRatesScreen());
                    // },
                    // widget: trackHistoryList([2, 2, 2, 3]),
                    // list: [2, 2, 2, 3],
                    // limit: [2, 2, 2, 3].length,  )
                    // trackHistoryList([2, 2, 2, 3]),

                    // animatedWidget(     
                    //     widget: itemTrackHistory(
                    //         // onTap: () {
                    //         //   // Get.to(() => OrderDetails());
                    //         // },
                    //         title: 'Nintendo Swich Oled',
                    //         subTitle: 'Order ID: JB39029910020'),
                    //     limit: 4),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
