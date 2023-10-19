import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/home/controller/banner_controller.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/banner_view.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/category_view.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/home_map_view.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/home_my_address.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/home_search_widget.dart';
import 'package:ride_sharing_user_app/view/screens/payment/controller/payment_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/images.dart';
import '../ride/controller/ride_controller.dart';
import '../ride/widgets/ride_category.dart';
import 'controller/category_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Get.find<CategoryController>().getCategoryList();
    printDeviceToken();
    super.initState();
    Get.find<BannerController>().getBannerList();
    Get.find<PaymentController>().getDigitalPaymentMethodList();

    Get.find<RideController>().resetControllerValue();

    // Get.back();
    // _checkPermission(context);
  }

  void printDeviceToken() async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    customPrint('Token: $deviceToken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(
          title: '${Strings.goodMorning.tr} ${'John'}',
          showBackButton: false,
          isHome: true,
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
