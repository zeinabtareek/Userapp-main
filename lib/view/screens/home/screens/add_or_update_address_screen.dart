import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../authenticate/presentation/widgets/test_field_title.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/images.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../ride/model/address_model.dart';
import '../controller/address_controller.dart';

class AddOrUpdateAddressScreen extends GetView<AddressController> {
  final AddressData? address;
  const AddOrUpdateAddressScreen({
    super.key,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    bool isEditAddress = address!.isHaveData;
    return WillPopScope(
      onWillPop: () {
        controller.disposeAddOrEditScreen();
        return Future.value(true);
      },
      child: Scaffold(
        body: CustomBody(
          appBar: CustomAppBar(
            title: _getText(isEditAddress),
            onBackPressed: () {
              controller.disposeAddOrEditScreen();
              Get.back();
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const TextFieldTitle(
                //   title: " Address Type",
                // ),
                // Obx(() => GenericDropdown<String>(
                //       items: AddressController.staticAddressNames,
                //       itemToString: (p0) => p0,
                //       onChanged: (item) {
                //         controller.changAddressName(item!, address: address);
                //       },
                //       selectedValue: controller.selectedAddressName.value,
                //       hintText: " Address Type",
                //       prefixIconPath: Images.location,
                //     )),
                TextFieldTitle(
                  title: Strings.address.tr,
                ),
                CustomTextField(
                  hintText: Strings.address.tr,
                  inputType: TextInputType.text,
                  prefixIcon: Images.location,
                  borderRadius: 20,
                  readOnly: true,
                  onTap: controller.naiveteToSelectAddress,
                  controller: controller.addressCompleteController,
                  // focusNode: controller.completeAddressFocusNode,
                  // nextFocus: authController.identityNumberNode,
                  // inputAction: TextInputAction.done,
                ),
                const Spacer(),
                Obx(
                  () => Visibility(
                    visible: controller.isUpdateData.isTrue,
                    child: CustomButton(
                      isLoading: controller.isLoading.isTrue,
                      radius: 20,
                      buttonText: _getText(isEditAddress),
                      onPressed: () {
                        controller.postAddress(
                          address: isEditAddress ? address : null,
                        );
                      },
                    ),
                  ),
                ),
                const Spacer(),
                if (isEditAddress)
                  Obx(
                    () => CustomButton(
                      isLoading: controller.isLoading.isTrue,
                      textColor: Colors.white,
                      radius: 20,
                      buttonText:'delete_saved_address'.tr,
                      onPressed: () {
                        controller.deleteAddress(
                          address: address!,
                        );
                      },
                    ),
                  ),
                if (isEditAddress) const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getText(bool isEditAddress) =>
      isEditAddress ? "Edit Saved Address " : "Crate Saved Address";
}
