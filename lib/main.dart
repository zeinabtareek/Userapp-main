import 'dart:convert';
import 'dart:io';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';
import 'package:ride_sharing_user_app/authenticate/domain/use-cases/auth_cases.dart';
import 'package:ride_sharing_user_app/firebase_options.dart';
import 'package:ride_sharing_user_app/helper/notification_helper.dart';
import 'package:ride_sharing_user_app/theme/dark_theme.dart';
import 'package:ride_sharing_user_app/util/app_strings.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/history/history_screen.dart';
import 'package:ride_sharing_user_app/view/screens/invoice/screens/invoice_screen.dart';
import 'package:ride_sharing_user_app/view/screens/message/message_list.dart';
import 'package:ride_sharing_user_app/view/screens/message/message_screen.dart';
import 'package:ride_sharing_user_app/view/screens/n/test_polyline_screen.dart';
import 'package:ride_sharing_user_app/view/screens/request_screens/controller/base_map_controller.dart';
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
import 'package:ride_sharing_user_app/view/screens/wallet/wallet_withdraw_screen.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/payment_method_screen.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/widget/use_voucher_code.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/model/distance_model.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/test_where_to_go.dart';
import 'package:ride_sharing_user_app/view/widgets/animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app_navigator_observer.dart';
import 'authenticate/presentation/sign-up/sign_up_screen.dart';
import 'helper/cache_helper.dart';
import 'helper/route_helper.dart';
import 'initialize_dependencies.dart';
import 'theme/dark_theme.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

DotEnv dotenv = DotEnv();
Future<void> main() async {
  if (ResponsiveHelper.isMobilePhone) {
    HttpOverrides.global = MyHttpOverrides();
  }
  WidgetsFlutterBinding.ensureInitialized();

  if(!Platform.isIOS) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Map<String, Map<String, String>> languages = await di.init();

  await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  await initializeDependencies();
  try {
    await dotenv.load(fileName: ".env");
  }catch(e){
    print('the env file error id::: ${e.toString()}');
  }
  ChuckerFlutter.showOnRelease = true;
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({super.key, required this.languages});

  void _route() async {
    bool isSuccess = await Get.find<ConfigController>().getConfigData();
    if (isSuccess) {}
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    if (GetPlatform.isWeb) {
      Get.find<ConfigController>().initSharedData();
      _route();
    }
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(
          //  init: LocalizationController().. ,
          builder: (localizeController) {
        return GetBuilder<ConfigController>(builder: (configController) {
          return (GetPlatform.isWeb && configController.config == null)
              ? const SizedBox()
              : Listener(
                  onPointerUp: (_) {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus &&
                        currentFocus.focusedChild != null) {
                      currentFocus.focusedChild!.unfocus();
                    }
                  },
                  // app_navigator_observer

                  child: ScreenUtilInit(
                      designSize: const Size(460, 847),
                      builder: (context, child) {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown,
                        ]);
                        return GetMaterialApp(
                          title: AppConstants.appName,
                          debugShowCheckedModeBanner: false,
                          navigatorObservers: [
                            ScreenObserver(),
                            ChuckerFlutter.navigatorObserver
                          ],
                          navigatorKey: Get.key,
                          scrollBehavior:
                              const MaterialScrollBehavior().copyWith(
                            dragDevices: {
                              PointerDeviceKind.mouse,
                              PointerDeviceKind.touch 
                            },
                          ),
                          theme: themeController.isDarkTheme
                              ? darkTheme
                              : lightTheme,
                          locale: localizeController.locale,
                          translations: Messages(languages: languages),
                          fallbackLocale: Locale(
                              AppConstants.languages[0].languageCode,
                              AppConstants.languages[0].countryCode),
                         initialRoute: RouteHelper.getSplashRoute(),
                           getPages: RouteHelper.routes,
                          defaultTransition: Transition.topLevel,
                          transitionDuration: const Duration(milliseconds: 500),

                        // home:DistanceWidget(
                        //   source: LatLng(37.7749, -122.4194), // San Francisco
                        //   destination: LatLng(34.0522, -118.2437), // Los Angeles
                        // ),







                         // home:PaymentScreen(),
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
                          // home: DashboardScreen(),
                        );
                      }));
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


void showToast(context, status) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      "Status: $status",
      style: const TextStyle(fontSize: 20),
    ),
  ));
}




class DistanceWidget extends StatefulWidget {
  final LatLng source;
  final LatLng destination;

  DistanceWidget({required this.source, required this.destination});

  @override
  _DistanceWidgetState createState() => _DistanceWidgetState();
}

class _DistanceWidgetState extends State<DistanceWidget> {
  String distance = '';
  String duration = '';
final con=Get.put(BaseMapController());
  @override
  void initState() {
    super.initState();
    calculateDistance();
  }

  void calculateDistance() async {
    DistanceModel model = await calculate(widget.source, widget.destination);
    setState(() {
      distance = model.rows?[0].elements?[0].distance?.text ?? '';
      duration = model.rows?[0].elements?[0].duration?.text ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Distance: $distance'),
        Text('Duration: $duration'),
        Text('distance.value: ${con.distance.value}'),
        TextButton(onPressed: () async {
          con.calculateDistance([LatLng(37.7749, -122.4194), // San Francisco
             LatLng(34.0522, -118.2437),]);

         // var x= await con.calculateDuration([LatLng(37.7749, -122.4194), // San Francisco
         //    LatLng(34.0522, -118.2437),]);
         //
         // print('duartion $x');
        }, child: Text('ddd')),
      ],
    );
  }
}

calculate(LatLng source, LatLng destination) async {
  DistanceModel model;
  String url =
      "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${source.latitude},${source.longitude}&destinations=${destination.latitude},${destination.longitude}&key=AIzaSyBGOAVKbeA0MiN6NfGm8Z0y5LtE7cgdCo4";
  http.Response res = await http.get(
    Uri.parse(url),
  );
  print(jsonDecode(res.body));
  //   log("token is : ${SharedPref.getTokenValue()}");
  if (res.statusCode == 200) {
    // print(jsonDecode(res.body));
    model = DistanceModel.fromJson(jsonDecode(res.body));
    return model;
  } else if (res.statusCode == 401) {
    print(res.statusCode);
  } else if (res.statusCode == 500 ||
      res.statusCode == 501 ||
      res.statusCode == 504 ||
      res.statusCode == 502) {
    print(res.statusCode);
  }
}