import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/firebase_options.dart';
import 'package:ride_sharing_user_app/helper/notification_helper.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/home/home_screen.dart';
import 'package:ride_sharing_user_app/view/screens/n/test_polyline_screen.dart';
import 'package:ride_sharing_user_app/view/screens/splash/controller/config_controller.dart';
import 'package:ride_sharing_user_app/helper/responsive_helper.dart';
import 'package:ride_sharing_user_app/helper/di_container.dart' as di;
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/localization/messages.dart';
import 'package:ride_sharing_user_app/theme/dark_theme.dart';
import 'package:ride_sharing_user_app/theme/light_theme.dart';
import 'package:ride_sharing_user_app/theme/theme_controller.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';

import 'authenticate/presentation/sign-up/sign_up_screen.dart';
import 'helper/cache_helper.dart';
import 'helper/route_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Future<void> main() async {
//
//
//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarIconBrightness: Brightness.dark, // dark text for status bar
//       statusBarColor: Colors.transparent),
//   );
//
//   if(ResponsiveHelper.isMobilePhone) {
//     HttpOverrides.global = MyHttpOverrides();
//   }
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   Map<String, Map<String, String>> languages = await di.init();
//
//   await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
//   FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
//
//   runApp(MyApp(languages: languages));
// }
//
// class MyApp extends StatelessWidget {
//   final Map<String, Map<String, String>> languages;
//   const MyApp({super.key, required this.languages});
//
//   void _route() async {
//     bool isSuccess = await Get.find<ConfigController>().getConfigData();
//     if (isSuccess) {
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if(GetPlatform.isWeb) {
//       Get.find<ConfigController>().initSharedData();
//       _route();
//     }
//     // final authController = Get.find<AuthController>();
//     return GetBuilder<ThemeController>(builder: (themeController) {
//       return GetBuilder<LocalizationController>(builder: (localizeController) {
//         return GetBuilder<ConfigController>(builder: (configController) {
//           return (GetPlatform.isWeb && configController.config == null) ? const SizedBox() :Listener(
//               onPointerUp: (_) {
//             FocusScopeNode currentFocus = FocusScope.of(context);
//             if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
//               currentFocus.focusedChild!.unfocus();
//             }
//           },
//           child:  GetMaterialApp(
//             title: AppConstants.appName,
//             debugShowCheckedModeBanner: false,
//             navigatorKey: Get.key,
//             scrollBehavior: const MaterialScrollBehavior().copyWith(
//               dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
//             ),
//             theme: themeController.darkTheme ? darkTheme : lightTheme,
//             locale: localizeController.locale,
//             translations: Messages(languages: languages),
//             fallbackLocale: Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),
//             // initialRoute: RouteHelper.getSplashRoute(),
//             // getPages: RouteHelper.routes,
//             defaultTransition: Transition.topLevel,
//             transitionDuration:   Duration(milliseconds: 500),
//
//
//             // home: MapPage(),
//             // home: TestMarkerPin(),
//             // home: DashboardScreen(),
//           ));
//         });
//       });
//     });
//   }
// }



class MyController extends GetxController {
  // Define an RxBool to track the visibility state of the container
  RxBool isContainerVisible = false.obs;
}

class MyApp extends StatelessWidget {
  final MyController controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Obx(() => AnimatedContainer(
        height: controller.isContainerVisible.value ? 50 : 0,
        duration: Duration(milliseconds: 500),
        decoration: getBoxShadow(),

        child: TextFormField(
          decoration: getInoutDecoration(
            controller.isContainerVisible.value
                ? 'Select Destination'
                : null,
            controller.isContainerVisible.value
                ? Icon(Icons.location_on)
                : null,
            controller.isContainerVisible.value,
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.isContainerVisible.toggle();
        },
        child: Icon(Icons.play_arrow),
      ),
    );}

  InputDecoration getInoutDecoration(
      String? hint, Icon? icon, bool isContainerVisible) {
    return InputDecoration(
      icon: Container(
        margin: const EdgeInsets.only(
          left: 20,
        ),
        width: 10,
        height: 10,
        child: icon,
      ),
      hintText: hint,
      border: InputBorder.none,
      hintStyle: isContainerVisible
          ? TextStyle(fontSize: 14.0)
          : TextStyle(color: Colors.transparent),
      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
    );
  }

  BoxDecoration getBoxShadow() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    );
  }
}

void main() {
  runApp(GetMaterialApp(home: MyApp()));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
