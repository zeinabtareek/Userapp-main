import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/parcel_rout_widget.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/text_style.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_calender.dart';
import '../../widgets/custom_drop_down.dart';

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
                    Container(
                      width: 120,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .primaryColor
                            .withOpacity(0.06),
                        borderRadius: BorderRadius.circular(
                            Dimensions.radiusOverLarge),
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.2),
                        ),
                      ),
                      // padding:  K.fixedPadding0,
                      child: Center(
                        child: CustomDropDown(
                          icon: Icon(
                            Icons.expand_more,
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .color!
                                .withOpacity(0.5),
                          ),
                          maxListHeight: 200,
                          items: x
                              .map((item) =>
                              CustomDropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item.tr,
                                  style: textRegular.copyWith(
                                      color:
                                      item != x.first
                                          ? Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color!
                                          .withOpacity(0.5)
                                          : Theme.of(context)
                                          .primaryColor),
                                ),
                              ))
                              .toList(),
                          hintText: Strings.select.tr,
                          borderRadius: 5,
                          onChanged: (selectedItem) {

                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
final List<String> x = ['1 kg', '2 kg', '3 kg', '4 kg'];
