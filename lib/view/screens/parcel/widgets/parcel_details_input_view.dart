import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/parcel_category_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

import '../../../../authenticate/presentation/widgets/test_field_title.dart';

class ParcelDetailInputView extends StatefulWidget {
  const ParcelDetailInputView({Key? key}) : super(key: key);

  @override
  State<ParcelDetailInputView> createState() => _ParcelDetailInputViewState();
}

class _ParcelDetailInputViewState extends State<ParcelDetailInputView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: GetBuilder<ParcelController>(builder: (parcelController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const ParcelCategoryView(),
            TextFieldTitle(
              title: 'category'.tr,
              textOpacity: 0.8,
            ),
            CustomTextField(
              prefixIcon: Images.editProfilePhone,
              borderRadius: 10,
              showBorder: false,
              hintText: 'category'.tr,
              isEnabled: false,
              fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
              controller: parcelController.parcelTypeController,
              prefix: false,
            ),
            TextFieldTitle(
              title: 'parcel_dimension'.tr,
              textOpacity: 0.8,
            ),
            CustomTextField(
              prefixIcon: Images.editProfilePhone,
              borderRadius: 10,
              showBorder: false,
              hintText: 'parcel_dimension'.tr,
              fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
              controller: parcelController.parcelDimensionController,
              focusNode: parcelController.parcelDimensionNode,
              nextFocus: parcelController.parcelWeightNode,
              inputType: TextInputType.text,
            ),
            TextFieldTitle(
              title: 'parcel_weight'.tr,
              textOpacity: 0.8,
            ),
            CustomTextField(
              prefixIcon: Images.editProfilePhone,
              borderRadius: 10,
              showBorder: false,
              hintText: 'parcel_weight'.tr,
              fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
              controller: parcelController.parcelWeightController,
              focusNode: parcelController.parcelWeightNode,
              inputType: TextInputType.text,
              inputAction: TextInputAction.done,
              prefix: false,
            ),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            CustomButton(
              buttonText: "save_details".tr,
              onPressed: () {
                parcelController
                    .updateParcelState(ParcelDeliveryState.parcelInfoDetails);
                parcelController.updateParcelDetailsStatus();
              },
            ),
          ],
        );
      }),
    );
  }
}
