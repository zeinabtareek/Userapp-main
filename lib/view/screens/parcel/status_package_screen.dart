import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/parcel_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/horizontal_taps.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/item_track_history_card.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/order_status_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/track_order_with_status.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'delivery_staus_screen.dart';

class StatusPackageScreen extends StatelessWidget {
  const StatusPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBody(
      appBar: CustomAppBar(
        title: Strings.statusPackage.tr,
        showBackButton: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            K.sizedBoxH0,
            Padding(
              padding: K.fixedPadding0,
              child: const CustomTextField(
                hintText: 'Tracking number or package name...',
                inputType: TextInputType.name,
                suffixIcon: Images.close,
                prefixIcon: Images.search,
                fillColor: Color(0xffEDF7F6),
                inputAction: TextInputAction.next,
              ),
            ),
            horizontalTaps(),
            K.sizedBoxH2,
            GestureDetector(
              child: Container(
                padding: K.fixedPadding0,
                margin: K.fixedPadding0,
                decoration: K.shadowBoxDecoration,
                child: Column(
                  children: [
                    itemTrackHistory(
                      title:
                      'New York, NY, 10016, USA',
                        subTitle:
                        'Order ID: JB390299191242',
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                        ),
                        elevated: 0, onTap: () {  }),
                    orderStatusWidget((){},isReturned: false,text: Strings.delivered.tr,),

                    K.sizedBoxH2,
                      Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: RouteWidget(),
                    ),




                  ],
                ),
              ),
              onTap: (){
                Get.to(DeliveryStatusScreen());
              },
            ), Padding(
              padding: K.fixedPadding0,
              child: Column(
                children: [
                trackOrderWithStatus(isReturned: false, text: Strings.returned.tr,onpressed: (){}),
                trackOrderWithStatus(isReturned: true, text: Strings.delivered.tr,onpressed: (){})


                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
