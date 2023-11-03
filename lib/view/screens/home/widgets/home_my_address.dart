import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../enum/view_state.dart';
import '../../wallet/widget/custom_title.dart';
import '../controller/address_controller.dart';
import 'address_item_card.dart';

class HomeMyAddress extends StatelessWidget {
  final String? title;
  final String? fromPage;

  const HomeMyAddress({Key? key, this.title, this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
        // init: AddressController()..getAddressList(),
        initState: (_) => Get.find<AddressController>()..getAddressList() ,
        builder: (addressController) {
          return Column(
            children: [
              CustomTitle(
                  title: title ?? 'my_address'.tr,
                  color: Theme.of(context).textTheme.displayLarge!.color),

              ///zeinab remove the comment

              SizedBox(
                height: 35,
                child: addressController.state == ViewState.busy
                    ? SizedBox()
                    : ListView.builder(
                        itemCount: addressController.addressModel.data?.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var item =
                              addressController.addressModel.data![index];
                          return AddressItemCard(
                            item: item,
                            // addressModel: addressController.addressList[index],
                            fromPage: fromPage!,
                          );
                        }),
              ),


              SizedBox(height: 30.h,)
            ],
          );
        });
  }
}
