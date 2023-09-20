import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/authenticate/domain/use-cases/auth_cases.dart';
import 'package:ride_sharing_user_app/firebase_options.dart';
import 'package:ride_sharing_user_app/helper/notification_helper.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/home/home_screen.dart';
import 'package:ride_sharing_user_app/view/screens/n/test_polyline_screen.dart';
import 'package:ride_sharing_user_app/view/screens/onboard/onboarding_screen.dart';
import 'package:ride_sharing_user_app/view/screens/onboarding/onboarding.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/add_shipment.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/parcel_home_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/parcel_notification_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/parcel_screen.dart';
import 'package:ride_sharing_user_app/view/screens/splash/controller/config_controller.dart';
import 'package:ride_sharing_user_app/helper/responsive_helper.dart';
import 'package:ride_sharing_user_app/helper/di_container.dart' as di;
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/localization/messages.dart';
import 'package:ride_sharing_user_app/theme/dark_theme.dart';
import 'package:ride_sharing_user_app/theme/light_theme.dart';
import 'package:ride_sharing_user_app/theme/theme_controller.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:ride_sharing_user_app/view/screens/splash/splash_screen.dart';
import 'package:ride_sharing_user_app/view/screens/support/support.dart';
import 'package:ride_sharing_user_app/view/widgets/animated_widget.dart';

import 'authenticate/presentation/sign-up/sign_up_screen.dart';
import 'helper/cache_helper.dart';
import 'helper/route_helper.dart';
import 'initialize_dependencies.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {




  if(ResponsiveHelper.isMobilePhone) {
    HttpOverrides.global = MyHttpOverrides();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Map<String, Map<String, String>> languages = await di.init();

  await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({super.key, required this.languages});

  void _route() async {
    bool isSuccess = await Get.find<ConfigController>().getConfigData();
    if (isSuccess) {

    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    if(GetPlatform.isWeb) {
      Get.find<ConfigController>().initSharedData();
      _route();
    }
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<ConfigController>(builder: (configController) {
          return (GetPlatform.isWeb && configController.config == null) ? const SizedBox() :Listener(
              onPointerUp: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              currentFocus.focusedChild!.unfocus();
            }
          },
          child:  GetMaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
            ),
            theme: themeController.darkTheme ? darkTheme : lightTheme,
            locale: localizeController.locale,
            translations: Messages(languages: languages),
            fallbackLocale: Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),
            // initialRoute: RouteHelper.getSplashRoute(),
            // getPages: RouteHelper.routes,
            defaultTransition: Transition.topLevel,
            transitionDuration:   Duration(milliseconds: 500),
            // home: Test(),

            // home: HelpAndSupportScreen(),
            // home: AnimatedContainerExample(),
            // home: ParcelHomeScreen(),
            // home: ParcelNotificationScreen(),
            // home: AddShipmenScreen(),
            home: OnBoardingScreen2(),
            // home: DashboardScreen(),
          ));
        });
      });
    });
  }
}



class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}






class AnimatedContainerExample extends StatefulWidget {
  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  double _containerHeight = 0.0;
  bool _isExpanded = false;

  void _toggleContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
      _containerHeight = _isExpanded ? 80.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Container Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: 200,
              height: _containerHeight,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleContainer,
              child: Text(_isExpanded ? 'Collapse' : 'Expand'),
            ),
          ],
        ),
      ),
    );
  }
}


// class Test extends StatelessWidget {
//   const Test({super.key});
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Animated Row Example'),
//       ),
//       body: Scaffold(
//         body: Column(
//           children: [
//             animatedWidget(widget: Text('data'),limit: 6)
//           ],
//         ),
//       )
//     );
//   }
// }


//            ...List.generate(999, (index) =>Text('Scroll Alert Example $index'),)


