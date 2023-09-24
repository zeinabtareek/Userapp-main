
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/history_model.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/rider_details.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/contact_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/fare_input_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/finding_rider_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/get_price.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/otp_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/tolltip_widget.dart';
import 'package:ride_sharing_user_app/view/screens/payment/payment_screen.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/confirmation_trip_dialog.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/estimated_fare_and_distance.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/ride_category.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/ride_expendable_bottom_sheet.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/rider_details_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/rise_fare_widget.dart';
import 'package:ride_sharing_user_app/view/screens/ride/widgets/trip_fare_summery.dart';
import 'package:ride_sharing_user_app/view/widgets/confirmation_dialog.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/custom_category_card.dart';

class GetPriceWidget extends StatelessWidget {
   String image;
  String title;

   GetPriceWidget({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'your selected car type is : $title', style: textRegular.copyWith(
              color: Theme
                  .of(context)
                  .primaryColor, fontWeight: FontWeight.w600),),
          K.sizedBoxH0,

          Center(
            child: GestureDetector(
              onTap: () {},
              child: CustomCategoryCard(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 7,
                image: image,
                title: title,
                isClicked: false,
              ),
            ),
          ),
          K.sizedBoxH0,
          RouteWidget(),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          // const TripFareSummery(),
          Padding(
            padding:
            const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                    Text(Strings.price.tr,
                      style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge),
                    ),

                const SizedBox(width: Dimensions.paddingSizeSmall),
                  Text('200 \$',style: textSemiBold.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .color!
                        .withOpacity(0.8),
                    fontSize: Dimensions.fontSizeLarge),),
              ],
            ),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          Padding(
            padding: const EdgeInsets.only( right: 8.0,left: 8),
            child: Text(Strings.doYouHaveAnyPromoCode.tr,style: textSemiBold.copyWith(
                color: Theme.of(context)
                    .hintColor
                    .withOpacity(0.8),
                fontSize: Dimensions.fontSizeDefault),),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
            Row(
              children: [
                  Expanded(
                  flex: 2,
                  child: CustomTextField(
                  prefix: false,
                  borderRadius: Dimensions.radiusLarge,
                  hintText: Strings.promoCode.tr,
          ),
                ),
                K.sizedBoxW0,
                Expanded(child:   CustomButton(
                    radius: 50,
                    buttonText: Strings.apply.tr,
                    onPressed: () {
                      rideController
                          .updateRideCurrentState(RideState.findingRider);
                    }),)
              ],
            ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),



          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.yourPriceAfterDiscount.tr,    style: textRegular.copyWith(
      fontSize: Dimensions.fontSizeLarge),),

              Text('100.0\$',style: textSemiBold.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .color!
                      .withOpacity(0.8),
                  fontSize: Dimensions.fontSizeExtraLarge),),
            ],
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          CustomButton(
            radius: 50,
              buttonText: Strings.findDriver.tr,
              onPressed: () {
                rideController
                    .updateRideCurrentState(RideState.findingRider);
              }),
          K.sizedBoxH0,
          K.sizedBoxH0,
        ],
      );
    }
    );
  }
}
