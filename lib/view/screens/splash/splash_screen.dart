// import 'dart:async';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ride_sharing_user_app/authenticate/domain/use-cases/auth_cases.dart';
// import 'package:ride_sharing_user_app/initialize_dependencies.dart';
// import 'package:ride_sharing_user_app/util/images.dart';
// import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
// import 'package:ride_sharing_user_app/view/screens/onboarding/onboarding.dart';
// import 'package:ride_sharing_user_app/view/screens/splash/controller/config_controller.dart';
//
// import '../../../authenticate/config/config.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   StreamSubscription<ConnectivityResult>? _onConnectivityChanged;
//
//   late AnimationController _controller;
//   late Animation _animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 2500));
//     _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       });
//     _controller.forward();
//
//     bool firstTime = true;
//     Connectivity connectivity = Connectivity();
//     connectivity.checkConnectivity();
//     _onConnectivityChanged =
//         connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       if (!firstTime) {
//         bool isNotConnected = result != ConnectivityResult.wifi &&
//             result != ConnectivityResult.mobile;
//         if (!isNotConnected)
//           ScaffoldMessenger.of(context).hideCurrentSnackBar();
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           backgroundColor: isNotConnected ? Colors.red : Colors.green,
//           duration: Duration(seconds: isNotConnected ? 6000 : 3),
//           content: Text(
//             isNotConnected ? 'no_connection'.tr : 'connected'.tr,
//             textAlign: TextAlign.center,
//           ),
//         ));
//         if (!isNotConnected) {
//           _route();
//         }
//       } else {
//         firstTime = false;
//       }
//     });
//
//     Get.find<ConfigController>().initSharedData();
//     _route();
//

// }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     _controller.dispose();
//     _onConnectivityChanged?.cancel();
//   }
//
//   void _route() async {}
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xff0CAD9A),
//                   Color(0xff007B6C),
//                 ],
//               ),
//             ),
//             alignment: Alignment.bottomCenter,
//             child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Stack(
//                     alignment: AlignmentDirectional.bottomCenter,
//                     children: [
//                       Container(
//                         transform: Matrix4.translationValues(
//                             0,
//                             320 -
//                                 (320 *
//                                     double.tryParse(
//                                         _animation.value.toString())!),
//                             0),
//                         child: Column(
//                           children: [
//                             Opacity(
//                               opacity: _animation.value,
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 120 -
//                                         ((120 *
//                                             double.tryParse(_animation.value
//                                                 .toString())!))),
//                                 child:
//                                     Image.asset(Images.splashLogo, width: 160),
//                               ),
//                             ),
//                             const SizedBox(height: 50),
//                             Image.asset(
//                               Images.splashBackgroundOne,
//                               width: Get.width,
//                               height: Get.height / 2,
//                               fit: BoxFit.cover,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         transform: Matrix4.translationValues(0, 20, 0),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: (70 *
//                                   double.tryParse(
//                                       _animation.value.toString())!)),
//                           child: Image.asset(
//                             Images.splashBackgroundTwo,
//                             width: Get.size.width,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ]),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

import '../../../util/images.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion(
            value:   SystemUiOverlayStyle(
              // statusBarColor: Color(0xff288c7b),
              statusBarColor: Theme.of(context).primaryColor,
              statusBarIconBrightness: Brightness.dark,
            ),
            child:         UpgradeAlert(
                upgrader: Upgrader(
                    dialogStyle: UpgradeDialogStyle.cupertino,

                    shouldPopScope: () => true
                ),

                child:Scaffold(
                // backgroundColor: Color(0xff288c7b),
                backgroundColor: Theme.of(context).primaryColor, //
                body: Center(
                  child: Image.asset(
                    Images.splash,
                    // height: 100,
                    width: MediaQuery.of(context).size.width,
                  ),
                ))));
  }
}
