import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';

import '../../../../pagination/typedef/page_typedef.dart';
import '../../../../pagination/widgets/paginations_widgets.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../history/model/history_model.dart';
import '../controller/parcel_controller.dart';
import '../screens/status_package_screen.dart';
import 'custom_oval.dart';

// Widget itemTrackHistory({
//   Icon? icon,
//   double? elevated,
//   required String title,
//   required String subTitle,
// }) {
//   return ItemTrackHistory();
// }

class ItemTrackHistory extends PaginationViewItem<HistoryData> {
  final Function()? onTap;
  const ItemTrackHistory({
    super.key,
    required super.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shadowColor: Colors.white10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
      ),
      child: ListTile(
        trailing: IconButton(
          icon: Icon(
            Icons.arrow_forward_ios_sharp,
            size: 15,
            color: Colors.grey.withOpacity(.7),
          ),
          onPressed: () {
            if (onTap != null) {
              onTap?.call();
            } else {
              Get.to(() => const StatusPackageScreen(),
                  binding: BindingsBuilder(() {
                // Get.find<ParcelController>().reSetFilter();
                // Get.find<PaginateParcelListPackageController>().onRefreshData();
              }));
            }
          },
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // TODO: pacge name
              // title ??
              data.packageName,
              style: const TextStyle(
                  color: Colors.black, fontSize: Dimensions.iconSizeSmall),
            ),
            Text(
              "${'order_id'.tr} : ${data.orderNum!}",
              style: TextStyle(
                  color: Colors.grey, fontSize: Dimensions.fontSizeSmall),
            ),
          ],
        ),
        leading: customOval(Image.asset(Images.package2),
            color: Colors.grey.withOpacity(.3)),
      ),
    );
  }
}
