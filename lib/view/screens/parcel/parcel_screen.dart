import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/route_widget.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_text_field.dart';

class ParcelScreen extends StatelessWidget {
  const ParcelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBody(
            appBar: CustomAppBar(
              title: Strings.addShipment.tr,
              showBackButton: true,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: K.fixedPadding0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    K.sizedBoxH0,
                    RouteWidget(
                        showTotalDistance: false,
                        isParcel: true,
                        ),
                    K.sizedBoxH0,
                    K.sizedBoxH0,
                    Text(Strings.shipmentType.tr,style: K.hintMediumTextStyle,),
                    K.sizedBoxH0,
                    Text(Strings.packageName.tr,style: K.hintMediumTextStyle,),
                    K.sizedBoxH0,
                     // K.sizedBoxH0,
                    const
                    CustomTextField(
                      hintText: '3john smith',
                      inputType: TextInputType.name,
                      // suffixIcon: Images.close,
                      prefixIcon: Images.location,
                      prefix: false,
                      fillColor: Color(0xffEDF7F6),
                      inputAction: TextInputAction.next,
                    ),
                    //
                    //
                    // Text(Strings.shippingTo.tr,style: K.semiBoldBlackTextStyle,),
                    // K.sizedBoxH0,
                    //




                  ],
                ),
              ),
            )
        )
    );
  }
}
