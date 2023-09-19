import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_text_field.dart';

class AddShipmenScreen extends StatelessWidget {
  const AddShipmenScreen({Key? key}) : super(key: key);

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

                Text(Strings.shippingFrom.tr,style: K.semiBoldBlackTextStyle,),
                K.sizedBoxH0,
                const CustomTextField(
                    hintText: '32 East 98th Street, New York, NY 10065 , The United States of America',
                    inputType: TextInputType.name,
                    // suffixIcon: Images.close,
                    prefixIcon: Images.location,
                    fillColor: Color(0xffEDF7F6),
                    inputAction: TextInputAction.next,
                  ),
                K.sizedBoxH0,
                const CustomTextField(
                    hintText: '  john smith ',
                    inputType: TextInputType.name,
                    prefix: false,
                    fillColor: Color(0xffEDF7F6),
                    inputAction: TextInputAction.next,
                  ), K.sizedBoxH0,
                const CustomTextField(
                    hintText: '  +1  2345 678 4321 ',
                    inputType: TextInputType.name,
                    prefix: false,
                    fillColor: Color(0xffEDF7F6),
                    inputAction: TextInputAction.next,
                  ),

                K.sizedBoxH0,
                K.sizedBoxH0,

                Text(Strings.shippingTo.tr,style: K.semiBoldBlackTextStyle,),
                K.sizedBoxH0,
                const CustomTextField(
                  hintText: '32 East 98th Street, New York, NY 10065 , The United States of America',
                  inputType: TextInputType.name,
                  // suffixIcon: Images.close,
                  prefixIcon: Images.location,
                  fillColor: Color(0xffEDF7F6),
                  inputAction: TextInputAction.next,
                ),
                K.sizedBoxH0,
                const CustomTextField(
                  hintText: '  john smith ',
                  inputType: TextInputType.name,
                  prefix: false,
                  fillColor: Color(0xffEDF7F6),
                  inputAction: TextInputAction.next,
                ), K.sizedBoxH0,
                const CustomTextField(
                  hintText: '  +1  2345 678 4321 ',
                  inputType: TextInputType.name,
                  prefix: false,
                  fillColor: Color(0xffEDF7F6),
                  inputAction: TextInputAction.next,
                ),
                K.sizedBoxH0, K.sizedBoxH0, K.sizedBoxH0,
                CustomButton(
                  // showBorder: false,
                  // borderWidth: 1,
                  // transparent: true,
                  // isLoading: false,
                  width: Get.width,

                  // height: 55,
                  buttonText: Strings.next.tr,
                  onPressed: () {
                   },
                  radius: 50,
                ),




              ],
            ),
          ),
        )
        )
    );
  }
}
