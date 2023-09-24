import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/rider_details.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/contact_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/distance_caculated_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/product_details_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/tolltip_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/otp_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

import '../../history/model/history_model.dart';

class CompletedParcelWidget extends StatelessWidget {
  const CompletedParcelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          TollTipWidget(
            title: "rider_details".tr,
          ),
          const OtpWidget(
            fromPage: 'parcel',
          ),
          ContactWidget(),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          // TODO: 
          // ActivityScreenRiderDetails(
          //   riderDetails: Driver(
          //       firstName: "mostafizur",
          //       rate: 5,
          //       img:
          //           "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",
          //       lastName: "smith"),
          //   // riderDetails: RiderDetails(
          //   //   name: "mostafizur",
          //   //   vehicleNumber: "DH-1234",
          //   //   rating: 5,
          //   //   vehicleType: "bike",
          //   //   vehicleName: "Pulser-150",
          //   //   image: "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"
          //   // ),
          // ),
       
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          RouteWidget(),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          const DistanceCalculatedWidget(),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          const ProductDetailsWidget(),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          CustomButton(
            buttonText: 'cancel_ride'.tr,
            transparent: true,
            borderWidth: 1,
            showBorder: true,
            radius: Dimensions.paddingSizeSmall,
            borderColor: Theme.of(Get.context!).primaryColor,
            onPressed: () {
              // showDialog(context: Get.context!, builder: (_)=> BiddingDialog(index: index,));
            },
          )
        ],
      ),
    );
  }
}
