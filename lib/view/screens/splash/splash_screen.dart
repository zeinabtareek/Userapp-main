// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ride_sharing_user_app/util/images.dart';
// import 'package:ride_sharing_user_app/view/screens/auth/controller/auth_controller.dart';
// import 'package:ride_sharing_user_app/view/screens/auth/sign_in_screen.dart';
// import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
// import 'package:ride_sharing_user_app/view/screens/onboard/onboarding_screen.dart';
// import 'package:ride_sharing_user_app/view/screens/splash/controller/config_controller.dart';
//
// import '../auth/sign_up_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   StreamSubscription<ConnectivityResult>? _onConnectivityChanged;
//
//   late AnimationController _controller;
//   late Animation _animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500));
//     _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       });
//     _controller.forward();
//
//     bool firstTime = true;
//     Connectivity connectivity = Connectivity();
//     connectivity.checkConnectivity();
//     _onConnectivityChanged = connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       if(!firstTime) {
//         bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
//         if(!isNotConnected) ScaffoldMessenger.of(context).hideCurrentSnackBar();
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           backgroundColor: isNotConnected ? Colors.red : Colors.green,
//           duration: Duration(seconds: isNotConnected ? 6000 : 3),
//           content: Text(
//             isNotConnected ? 'no_connection'.tr : 'connected'.tr,
//             textAlign: TextAlign.center,
//           ),
//         ));
//         if(!isNotConnected) {
//           _route();
//         }
//       }else {
//         firstTime = false;
//       }
//     });
//
//     Get.find<ConfigController>().initSharedData();
//     _route();
//
//
//     Future.delayed(const Duration(milliseconds: 2500), () {
//       if(Get.find<AuthController>().isLoggedIn()){
//         Get.offAll(const DashboardScreen());
//       }else{
//         if (Get.find<ConfigController>().showIntro()) {
//           Get.offAll(const OnBoardingScreen());
//         } else {
//           // Get.offAll(const SignUpScreen());
//           Get.offAll(  SignInScreen());
//         }
//       }
//     });
//
//   }
//   @override
//   void dispose() {
//     super.dispose();
//
//     _controller.dispose();
//     _onConnectivityChanged?.cancel();
//   }
//   void _route() async {
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const  BoxDecoration(
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
//             child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.end, children:  [
//
//
//               Stack(alignment: AlignmentDirectional.bottomCenter,
//                 children: [
//                   Container(
//                     transform: Matrix4.translationValues(0, 320-(320*double.tryParse(_animation.value.toString())!), 0),
//                     child: Column(
//                       children: [
//                         Opacity(
//                           opacity: _animation.value,
//                           child: Padding(
//                             padding: EdgeInsets.only(left: 120-((120*double.tryParse(_animation.value.toString())!))),
//                             child: Image.asset(Images.splashLogo,width: 160),
//                           ),
//                         ),
//                          const SizedBox(height: 50),
//                         Image.asset(
//                           Images.splashBackgroundOne,
//                           width: Get.width,
//                           height: Get.height/2,
//                           fit: BoxFit.cover,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     transform: Matrix4.translationValues(0, 20, 0),
//                     child: Padding(
//                       padding:EdgeInsets.symmetric(horizontal:(70*double.tryParse(_animation.value.toString())!)),
//                       child: Image.asset(Images.splashBackgroundTwo,
//                         width: Get.size.width,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//
//             ]),
//           ),
//
//         ],
//
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/authenticate/domain/use-cases/auth_cases.dart';
import 'package:ride_sharing_user_app/initialize_dependencies.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/onboarding/onboarding.dart';
import 'package:ride_sharing_user_app/view/screens/splash/controller/config_controller.dart';

import '../../../authenticate/config/config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  StreamSubscription<ConnectivityResult>? _onConnectivityChanged;

  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();

    bool firstTime = true;
    Connectivity connectivity = Connectivity();
    connectivity.checkConnectivity();
    _onConnectivityChanged =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        if (!isNotConnected)
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      } else {
        firstTime = false;
      }
    });

    Get.find<ConfigController>().initSharedData();
    _route();

    Future.delayed(const Duration(milliseconds: 2500), () async {
      if (await sl<AuthCases>().isAuthenticated()) {
        Get.offAll(DashboardScreen());
      } else {
    
       Get.off(const OnBoardingScreen2());
        // Get.offAllNamed(AuthScreenPath.loginScreenWithPassRouteName);

      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
    _onConnectivityChanged?.cancel();
  }

  void _route() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff0CAD9A),
                  Color(0xff007B6C),
                ],
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                        transform: Matrix4.translationValues(
                            0,
                            320 -
                                (320 *
                                    double.tryParse(
                                        _animation.value.toString())!),
                            0),
                        child: Column(
                          children: [
                            Opacity(
                              opacity: _animation.value,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 120 -
                                        ((120 *
                                            double.tryParse(_animation.value
                                                .toString())!))),
                                child:
                                    Image.asset(Images.splashLogo, width: 160),
                              ),
                            ),
                            const SizedBox(height: 50),
                            Image.asset(
                              Images.splashBackgroundOne,
                              width: Get.width,
                              height: Get.height / 2,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0, 20, 0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: (70 *
                                  double.tryParse(
                                      _animation.value.toString())!)),
                          child: Image.asset(
                            Images.splashBackgroundTwo,
                            width: Get.size.width,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
