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
import 'package:ride_sharing_user_app/util/app_strings.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/history/history_screen.dart';
import 'package:ride_sharing_user_app/view/screens/home/home_screen.dart';
import 'package:ride_sharing_user_app/view/screens/invoice/screens/invoice_screen.dart';
 import 'package:ride_sharing_user_app/view/screens/message/message_list.dart';
import 'package:ride_sharing_user_app/view/screens/message/message_screen.dart';
import 'package:ride_sharing_user_app/view/screens/n/test_polyline_screen.dart';
import 'package:ride_sharing_user_app/view/screens/onboard/onboarding_screen.dart';
import 'package:ride_sharing_user_app/view/screens/onboarding/onboarding.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/add_shipment.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/order_details_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/parcel_home_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/parcel_notification_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/parcel_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/item_track_history_card.dart';
import 'package:ride_sharing_user_app/view/screens/payment/credit_card_screen.dart';
import 'package:ride_sharing_user_app/view/screens/payment/payment_screen.dart';
import 'package:ride_sharing_user_app/view/screens/request_screens/screens/base_map/base_map_screen.dart';
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
import 'package:ride_sharing_user_app/view/screens/test.dart';
import 'package:ride_sharing_user_app/view/screens/test_payment.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/wallet_screen.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/payment_method_screen.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/use_voucher_code.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/withdraw_amount_screen.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/test_where_to_go.dart';
import 'package:ride_sharing_user_app/view/widgets/animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'app_navigator_observer.dart';
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
  await initializeDependencies();
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
          // app_navigator_observer
      
          child:  GetMaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            navigatorObservers: [ScreenObserver()],
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
            transitionDuration:   const Duration(milliseconds: 500),
            // home:MapView(),
            // ParcelHomeScreen(),
            // AnimatedWidget(items:['2','3','4','5','6'] ,isVertical: false,widget:  itemTrackHistory(onTap: (){
            //   Get.to(()=>OrderDetails());},
            //     title: 'Nintendo Swich Oled',
            //     subTitle: 'Order ID: JB39029910020'),),
            // AnimatedWidget(
            //   items: myList,
            //   isVertical: isVertical,
            //   widget: myWidget,),
            //   home: HelpAndSupportScreen(),
            //   home: AnimatedContainerExample(),
            //   home: ParcelHomeScreen(),
            //   home: ParcelNotificationScreen(),
            //   home: AddShipmenScreen(),
            //   home: AddShipmenScreen(),
            //   home: SplashScreen()/**/,
            //   home: const MessageListScreen()/**/,
            //   home: const MessageScreen()/**/,
            // home: const UseCouponScreen()/**/,
            // home:   HistoryScreen(fromPage: Strings.home,)/**/,
            // home: const WalletScreen()/**/,
            // home: const OnBoardingScreen2()/**/,
            // home: TestWhereToGo(address :'haram 2000 gate '),
            // home: InvoiceScreen(),
            // home: BaseMapScreen(),
            // home: HomeScreen1(),
            // home: SplashScreen(),
            // home: CreditCardScreen(),
            home: DashboardScreen(),
            // home: WithdrawAmountScreen(),
            // home: PaymentScreen(),
            // home: TestPaymentScreen(),
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



