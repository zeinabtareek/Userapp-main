import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../bases/base_controller.dart';
import '../../../../helper/display_helper.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_body.dart';
import '../../ride/widgets/ride_category.dart';
import '../controller/category_controller.dart';
import '../controller/home_view_controller.dart';
import '../widgets/banner_view.dart';
import '../widgets/home_my_address.dart';
import '../widgets/home_search_widget.dart';

class HomeScreen extends GetView<BaseController> {
  const HomeScreen({Key? key}) : super(key: key);

  void printDeviceToken() async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    customPrint('Token: $deviceToken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: GetBuilder<HomeViewController>(
        // appBar: GetBuilder<BaseController>(
        //   init: BaseController()..onInit(),
          init: HomeViewController()..getPermission(),
          initState: (_) {},
          builder: (controller) {
            return CustomAppBar(
              title: '${Strings.goodMorning.tr} ${controller.user?.viewName}',
              showBackButton: false,
              isHome: true,
              address: controller.myAddressString,
            );
          },
        ),
        body: Padding(
          padding: K.fixedPadding0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const BannerView(),
                K.sizedBoxH0,

                GetBuilder<CategoryController>(
                    initState: (_) =>
                        Get.find<CategoryController>().getCategoryList(),
                    builder: (categoryController) {
                      return const RideCategoryWidget();
                    }),
                K.sizedBoxH0,
                // const CategoryView(),
                const HomeSearchWidget(),
                const HomeMyAddress(
                  fromPage: Strings.home,
                ),
                // HomeMapView()
              ],
            ),
          ),
        ),
      ),
    );
  }
// void _checkPermission(BuildContext context) async {
//   LocationPermission permission = await Geolocator.checkPermission();
//   if(permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//   }
//   if(permission == LocationPermission.denied) {
//     // showDialog(context: context, barrierDismissible: false, builder: (context) => PermissionDialog(isDenied: true,
//     //     onPressed: () async {
//     //       Navigator.pop(context);
//     //       await Geolocator.requestPermission();
//     //
//     //     }));
//   }else if(permission == LocationPermission.deniedForever) {
//     // showDialog(context: context, barrierDismissible: false, builder: (context) => PermissionDialog(isDenied: false,
//     //     onPressed: () async {
//     //       Navigator.pop(context);
//     //       await Geolocator.openAppSettings();
//     //
//     //     }));
//   }
// }
}
