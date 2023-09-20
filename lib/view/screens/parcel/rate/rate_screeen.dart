import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../controller/parcel_controller.dart';
import '../widgets/custom_shipment_card.dart';
import '../widgets/delivery_parcel_option.dart';
import '../widgets/parcel_rout_widget.dart';
import 'controller/rate-controller.dart';

class RateScreen extends StatelessWidget {
  const RateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(RateController());
    return Scaffold(
        body: CustomBody(
            appBar: CustomAppBar(
              title: Strings.rate.tr,
              showBackButton: true,
              centerTitle: true,
            ),
            body:  Padding(
              padding: K.fixedPadding0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [  K.sizedBoxH0,
                    Container(
                      decoration: K.shadowBoxDecorationWithPrimary,
                      padding: K.fixedPadding0,
                      child: ParcelRouteWidget(
                          showTotalDistance: false,
                          isParcel: true,
                          colorText: Colors.white),
                    ),
                    K.sizedBoxH0,

                    Text(Strings.shipmentDetails.tr,style: K.semiBoldBlackTextStyle,),

                    K.sizedBoxH0,
                    K.sizedBoxH0,

                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                               Column(
                            children: [
                              const Text('Parcel',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.iconSizeSmall)),
                              Text(Strings.shipmentType.tr,
                                style: K.hintMediumTextStyle,
                              ),
                            ],
                          ),
                          K.sizedBoxW0,
                          Container(width: 1, color: Colors.grey.withOpacity(.5)),
                          K.sizedBoxW0, Column(
                            children: [
                              const Text('1',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.iconSizeSmall)),
                              Text(Strings.quantity.tr,
                                style: K.hintMediumTextStyle,
                              ),
                            ],
                          ),
                          K.sizedBoxW0,
                          Container(width: 1, color: Colors.grey.withOpacity(.5)),
                          K.sizedBoxW0,
                          Column(
                            children: [
                              const Text('22.kg',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.iconSizeSmall)),
                              Text(Strings.weight.tr,
                                style: K.hintMediumTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    K.sizedBoxH0,
                    K.sizedBoxH0,
                    GetBuilder<ParcelController>(
                      builder: (controller) {
                        return DeliveryParcelOptions(
                          height: 88,
                          onPressed: controller.isTapped,
                          isTapped: controller.isBtnTapped.value,
                          isSelected: controller.isSelected.value,
                        );
                      },
                    ),

                    K.sizedBoxH0,
                    K.sizedBoxH0,
                    CustomShipmentCard(
                      leftButtonText:'3Day ',
                      rightButtonText:'\$18 ',
                      desc:'Luctus nam arcu est venenatis semper velit. Lectus enim ut tristique nunc.  Neque massa nec scelerisque urna mauris. Quisque egestas tempus arcu at tortor amet egestas vivamus.'

                    )

                  ],
                ),
              ),

            )));
  }
}
