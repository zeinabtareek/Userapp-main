import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/custom_oval.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/images.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_image.dart';
import '../../home/widgets/home_map_view.dart';
import '../../ride/widgets/rider_details_widget.dart';

class LiveTrackingScreenForParcel extends StatelessWidget {
  const LiveTrackingScreenForParcel({super.key});

  @override
  Widget build(BuildContext context) {
    double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
    return Scaffold(
      body: CustomBody(
          appBar: CustomAppBar(
            title: Strings.liveTracking.tr,
            showBackButton: true,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.only(
              top: Dimensions.fontSizeSmall,
              right: Dimensions.fontSizeExtraLarge,
              left: Dimensions.fontSizeExtraLarge,
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        decoration: K.shadowBoxDecoration,
                        height: 400,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              Dimensions.paddingSizeSmall),
                          child: GoogleMap(
                              mapType: MapType.normal,
                              myLocationEnabled: true,
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: true,
                              onTap: (p) {
                                print(p);
                              },
                              onCameraMove: (poistion) {
                                print(poistion);
                              },
                              initialCameraPosition: CameraPosition(
                                  target:
                                      LatLng(_originLatitude, _originLongitude),
                                  zoom: 15),
                              onMapCreated: (gController) async {}),
                        )),
                    Positioned(
                        bottom: Dimensions.iconSizeSmall,
                        right: Dimensions.iconSizeSmall,
                        child: Row(
                          children: [
                            FloatingActionButton(
                                onPressed: () {},
                                backgroundColor: K.lightGreen2,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                )),
                            K.sizedBoxW0,
                            FloatingActionButton(
                                onPressed: () {},
                                backgroundColor: K.lightGreen2,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                )),
                          ],
                        ))
                  ],
                ),
                K.sizedBoxH0,
                K.sizedBoxH0,
                Container(
                  decoration: K.shadowBoxDecorationWithPrimary,
                  padding: K.fixedPadding0,
                  child: RouteWidget(
                      showTotalDistance: false,
                      isParcel: true,
                      colorText: Colors.white),
                ),
                K.sizedBoxH0,
                K.sizedBoxH0,
                Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const CustomImage(
                          height: Dimensions.orderStatusIconHeight,
                          width: Dimensions.orderStatusIconHeight,
                          image:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtWX3ukDq0WGD12qlTzZuoM21blxeCRCrhi5ng_BP568fBg3EZSzskjpIgDhn95Id7_Es&usqp=CAU',
                        )),
                    K.sizedBoxW0,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cristofer George',
                            style: K.semiBoldBlackTextStyle),
                        Text(
                          'Courier - Express',
                          style: K.hintSmallTextStyle,
                        ),
                        K.sizedBoxH0,
                      ],
                    ),
                    Spacer(),
                    customOval(
                        Icon(Icons.message_outlined,
                            color: Theme.of(context).primaryColor),
                        color: Theme.of(context).cardColor,
                        borderColor: Theme.of(context).primaryColor),
                    K.sizedBoxW0,
                    customOval(const Icon(Icons.phone, color: Colors.white),
                        color: Theme.of(context).primaryColor,
                        borderColor: Theme.of(context).primaryColor),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // K.sizedBoxW0,
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          Strings.statusOrder.tr,
                          style: K.hintMediumTextStyle,
                        )),
                    K.sizedBoxW0,
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          Strings.packageWeight.tr,
                          style: K.hintMediumTextStyle,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      backgroundColor: K.lightGreen,
                      isLoading: false,
                      textColor: Theme.of(Get.context!).primaryColor,
                      height: 30,
                      buttonText: 'In Delivery Courier',
                      width: 200,
                      onPressed: () {},
                      radius: 50,
                    ),
                    Text(
                      '4 KG',
                      style: K.semiBoldBlackTextStyle,
                    ),
                    K.sizedBoxW0,
                  ],
                ),
                K.sizedBoxH0,
                K.sizedBoxH0,
              ],
            ),
          ))),
    );
  }
}
