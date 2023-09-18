import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/parcel_screen.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_body.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

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
      body: Column(
        children: [
          K.sizedBoxH0,
          Padding(
            padding: K.fixedPadding0,
            child: const CustomTextField(
              hintText: '',
              inputType: TextInputType.name,
              suffixIcon: Images.close,
              prefixIcon: Images.search,
              fillColor: Color(0xffEDF7F6),
              inputAction: TextInputAction.next,
            ),
          ),
          horizontalTaps(),
          K.sizedBoxH2,
            Padding(
              padding: K.fixedPadding0,
              child: Card(child:  Column(
              children: [

                itemTrackHistory(icon: Icon(Icons.more_horiz,color: Colors.black,) ,elevated:0)
              ],
          ),),
            )
        ],
      ),
    ));
  }
}

Widget horizontalTaps() {
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
              9,
              (index) => Padding(
                    padding: EdgeInsets.only(left: Dimensions.iconSizeSmall),
                    child: CustomButton(
                      backgroundColor: index == 0
                          ? Theme.of(Get.context!).primaryColor
                          : Theme.of(Get.context!).hintColor.withOpacity(.1),
                      // backgroundColor: isSelected?Theme.of(context).primaryColor:Theme.of(context).hintColor,
                      isLoading: false,
                      textColor: index == 0
                          ? Theme.of(Get.context!).cardColor
                          : Theme.of(Get.context!).hintColor,

                      buttonText: Strings.sendOtp.tr,

                      width: 88,
                      onPressed: () {},
                      radius: 50,
                    ),
                  ))
        ],
      ));
}
