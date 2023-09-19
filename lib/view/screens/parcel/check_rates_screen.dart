import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/parcel_rout_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';

class CheckRatesScreen extends StatelessWidget {
  const CheckRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBody(
            appBar: CustomAppBar(
              title: Strings.checkRates.tr,
              showBackButton: true,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:K.fixedPadding0,
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
                    // Expanded(child: SizedBox()),
                  ],
                ),
              ),
            )));
  }
}
