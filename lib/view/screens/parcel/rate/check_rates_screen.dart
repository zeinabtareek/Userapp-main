import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/rate/rate_screeen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/parcel_rout_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/weight_and_package.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';
import '../controller/parcel_controller.dart';
import 'controller/rate-controller.dart';

class CheckRatesScreen extends StatelessWidget {
  const CheckRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(RateController());
    return Scaffold(
        body: CustomBody(
            appBar: CustomAppBar(
              title: Strings.checkRates.tr,
              showBackButton: true,
              centerTitle: true,
            ),
            body:  Padding(
                padding: K.fixedPadding0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Calculate for Shippment',
                        style: K.semiBoldBlackTextStyle),
                    K.sizedBoxH2,
                    Text(
                      'Set notification preferences for your purchases, payment & deliveries.',
                      style: K.hintMediumTextStyle,
                    ),

                    K.sizedBoxH0,
                    Container(
                      decoration: K.shadowBoxDecorationWithPrimary,
                      padding: K.fixedPadding0,
                      child: ParcelRouteWidget(
                          showTotalDistance: false,
                          isParcel: true,
                          colorText: Colors.white),
                    ),
                    K.sizedBoxH0,
                    K.sizedBoxH0,   GetBuilder<RateController>(builder: (controller) {
                      return WeightAndPackageWidget(
                        listOfItems: controller.kilosList,
                        initial: controller.kilosList.first,
                        counter: controller.counter,
                        addFun: controller.add,
                        minFun: controller.minimize,
                      );
                    }),
                    Expanded(child: SizedBox()),
                    CustomButton(
                      backgroundColor:Theme.of(context).primaryColor,
                      isLoading: false,
                      textColor: Theme.of(Get.context!).cardColor,
                      height: Dimensions.iconSizeDoubleExtraLarge,
                      buttonText:Strings.checkRates.tr,
                       onPressed: () {
                        Get.to(RateScreen());
                       },
                      radius: 50,
                    ),
                  ],
                ),

            )));
  }
}
