import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/auth/widgets/test_field_title.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/home_my_address.dart';
import 'package:ride_sharing_user_app/view/screens/map/controller/map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';

class SenderReceiverInfoWidget extends StatefulWidget {
  const SenderReceiverInfoWidget({Key? key}) : super(key: key);

  @override
  State<SenderReceiverInfoWidget> createState() => _SenderReceiverInfoWidgetState();
}
class _SenderReceiverInfoWidgetState extends State<SenderReceiverInfoWidget> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: GetBuilder<ParcelController>(builder: (parcelController){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.7,
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault+2),
              ),
              child: TabBar(
                controller: parcelController.tabController,
                unselectedLabelColor: Colors.grey,
                labelColor:  Colors.white ,
                labelStyle: textMedium.copyWith(),
                indicatorColor: Theme.of(context).primaryColor,
                indicator:  BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),

                ),
                tabs:  [
                  SizedBox(height: 30,child: Tab(text: 'sender_info'.tr)),
                  SizedBox(height: 30,child: Tab(text: 'receiver_info'.tr)),
                ],
                onTap: (index){
                  parcelController.updateTabControllerIndex(index);
                },
              ),
            ),

            parcelController.tabController.index==0
                ?_senderInfo(parcelController)
                :_receiverInfo(parcelController),

            CustomButton(
              buttonText: "next".tr,
              onPressed: (){
                if(parcelController.tabController.index==0){
                  if(parcelController.senderContactController.text.isEmpty){
                    showCustomSnackBar('enter_sender_contact_number'.tr);
                  }else if(parcelController.senderNameController.text.isEmpty){
                    showCustomSnackBar('enter_sender_name'.tr);
                  } else if(parcelController.senderNameController.text.isEmpty){
                    showCustomSnackBar('enter_sender_address'.tr);
                  }else{
                    parcelController.updateTabControllerIndex(1);
                  }
                }

                else{
                  if(parcelController.receiverContactController.text.isEmpty){
                    showCustomSnackBar('enter_receiver_contact_number'.tr);
                  }else if(parcelController.receiverNameController.text.isEmpty){
                    showCustomSnackBar('enter_receiver_name'.tr);
                  } else if(parcelController.receiverNameController.text.isEmpty){
                    showCustomSnackBar('enter_receiver_address'.tr);
                  }else{
                    parcelController.updateParcelState(ParcelDeliveryState.parcelInfoDetails);
                  }
                }
                Get.find<MapController>().notifyMapController();
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _senderInfo(ParcelController parcelController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldTitle(title: 'contact'.tr,textOpacity: 0.8,),
        CustomTextField(
          prefix: false,
          borderRadius: 10,
          showBorder: false,
          hintText: 'contact_number'.tr,
          fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
          controller: parcelController.senderContactController,
          focusNode: parcelController.senderContactNode,
          nextFocus: parcelController.senderNameNode,
          inputType: TextInputType.phone,
        ),

        TextFieldTitle(title: 'name'.tr,textOpacity: 0.8,),
        CustomTextField(
          prefixIcon: Images.editProfilePhone,
          borderRadius: 10,
          showBorder: false,
          prefix: false,
          hintText: 'name'.tr,
          fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
          controller: parcelController.senderNameController,
          focusNode: parcelController.senderNameNode,
          nextFocus: parcelController.senderAddressNode,
          inputType: TextInputType.text,
        ),


        TextFieldTitle(title: 'address'.tr,textOpacity: 0.8,),
        CustomTextField(
          prefix: false,
          suffixIcon: Images.addLocation,
          borderRadius: 10,
          showBorder: false,
          hintText: 'location'.tr,
          fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
          controller: parcelController.senderAddressController,
          focusNode: parcelController.senderAddressNode,
          inputType: TextInputType.text,
          inputAction: TextInputAction.done,
          onPressedSuffix: (){

          },
        ),


        HomeMyAddress(title: 'saved_address'.tr,fromPage: 'parcel',),
        K.sizedBoxH0,
        K.sizedBoxH0,
      ],
    );
  }

  Widget  _receiverInfo(ParcelController parcelController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldTitle(title: Strings.contact.tr,textOpacity: 0.8,),
        CustomTextField(
          borderRadius: 10,
          showBorder: false,
          prefix: false,
          hintText: Strings.contactNumber.tr,
          fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
          controller: parcelController.receiverContactController,
          focusNode: parcelController.receiverContactNode,
          nextFocus: parcelController.receiverNameNode,
          inputType: TextInputType.phone,
        ),

        TextFieldTitle(title: Strings.contact.tr,textOpacity: 0.8,),
        CustomTextField(
          prefixIcon: Images.editProfilePhone,
          borderRadius: 10,
          showBorder: false,
          prefix: false,
          hintText: Strings.name.tr,
          fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
          controller: parcelController.receiverNameController,
          focusNode: parcelController.receiverNameNode,
          nextFocus: parcelController.receiverAddressNode,
          inputType: TextInputType.text,
        ),


        TextFieldTitle(title: 'address'.tr,textOpacity: 0.8,),
        CustomTextField(
          suffixIcon: Images.addLocation,
          borderRadius: 10,
          showBorder: false,
          prefix: false,
          hintText: Strings.location.tr,
          fillColor: Theme.of(context).primaryColor.withOpacity(0.04),
          controller: parcelController.receiverAddressController,
          focusNode: parcelController.receiverAddressNode,
          inputType: TextInputType.text,
          inputAction: TextInputAction.done,
        ),

        HomeMyAddress(title: 'saved_address'.tr,fromPage: 'parcel',),
        K.sizedBoxH0,
        K.sizedBoxH0,
      ],
    );
  }
}
