

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
import 'package:gif_view/gif_view.dart';

import '../../../util/images.dart';
import 'controller/splash_controller.dart';

// class SplashScreen extends StatelessWidget {
//   SplashScreen({super.key});
//   final controller = Get.put(SplashController());
//   @override
//   Widget build(BuildContext context) {
//     return  AnnotatedRegion(
//             value:   SystemUiOverlayStyle(
//               statusBarColor: Theme.of(context).primaryColor,
//               statusBarIconBrightness: Brightness.dark,
//             ),
//             child:         UpgradeAlert(
//                 upgrader: Upgrader(
//                     dialogStyle: UpgradeDialogStyle.cupertino,
//
//                     shouldPopScope: () => true
//                 ),
//
//                 child:Scaffold(
//                 // backgroundColor: Color(0xff288c7b),
//                 backgroundColor: Theme.of(context).primaryColor, //
//                 body: Center(
//                   child: Image.asset(
//                     Images.splash,
//                     // height: 100,
//                     width: MediaQuery.of(context).size.width,
//                   ),
//                 ))));
//   }
// }


///---
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  GetBuilder<SplashController>(
        init: SplashController(),
        initState: (_) {},
        builder: (_) {
          return AnnotatedRegion(
              value: const SystemUiOverlayStyle(
                statusBarColor: Color(0xff288c7b),
                statusBarIconBrightness: Brightness.dark,
              ),
              child:  Scaffold(
                  backgroundColor: Theme.of(context).cardColor,
                  // backgroundColor: const Color(0xff288c7b),
                  body:
                  Center(
                    child: GifView.asset(Images.splash,
                      controller: _.gifController,
                      // height: 200,
                      // width: 200,
                    ),
                  )
              )
          ) ;}
      // ),
      //   );

    );}
}
