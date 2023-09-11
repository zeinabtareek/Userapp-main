import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api_client.dart';
import '../localization/language_model.dart';
import '../localization/localization_controller.dart';
import '../theme/theme_controller.dart';
import '../util/app_constants.dart';
import '../view/screens/auth/controller/auth_controller.dart';
import '../view/screens/auth/repository/auth_repo.dart';
import '../view/screens/dashboard/bottom_menu_controller.dart';
import '../view/screens/history/controller/activity_controller.dart';
import '../view/screens/history/repository/history_repo.dart';
import '../view/screens/home/controller/address_controller.dart';
import '../view/screens/home/controller/banner_controller.dart';
import '../view/screens/home/controller/category_controller.dart';
import '../view/screens/home/repository/address_repo.dart';
import '../view/screens/home/repository/banner_repo.dart';
import '../view/screens/home/repository/category_repo.dart';
import '../view/screens/map/controller/map_controller.dart';
import '../view/screens/message/controller/message_controller.dart';
import '../view/screens/message/repository/message_repo.dart';
import '../view/screens/notification/controller/notification_controller.dart';
import '../view/screens/notification/repository/notification_repo.dart';
import '../view/screens/offer/controller/offer_controller.dart';
import '../view/screens/offer/repository/offer_repo.dart';
import '../view/screens/onboard/controller/on_board_page_controller.dart';
import '../view/screens/parcel/controller/parcel_controller.dart';
import '../view/screens/parcel/repository/parcel_repo.dart';
import '../view/screens/payment/controller/payment_controller.dart';
import '../view/screens/payment/repository/payment_repo.dart';
import '../view/screens/profile/profile_screen/controller/user_controller.dart';
import '../view/screens/profile/repository/uer_repo.dart';
import '../view/screens/ride/controller/ride_controller.dart';
import '../view/screens/ride/repository/ride_repo.dart';
import '../view/screens/set_map/controller/set_map_controller.dart';
import '../view/screens/set_map/repository/set_map_repo.dart';
import '../view/screens/splash/controller/config_controller.dart';
import '../view/screens/splash/repo/config_repo.dart';
import '../view/screens/wallet/controller/wallet_controller.dart';
import '../view/screens/wallet/repository/wallet_repo.dart';
import 'cache_helper.dart';
import 'network/dio_integration.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  final dio = DioUtilNew.getInstance();
  Get.lazyPut(() => dio);
  Get.lazyPut(() => CacheHelper.init());
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(
      () => ConfigRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => NotificationRepo(apiClient: Get.find()));
  Get.lazyPut(() => ActivityRepo());
  // Get.lazyPut(() => ActivityRepo(apiClient: Get.find()));
  Get.lazyPut(() => WalletRepo(apiClient: Get.find()));
  Get.lazyPut(() => OfferRepo(apiClient: Get.find()));
  Get.lazyPut(() => BannerRepo(apiClient: Get.find()));
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => AddressRepo(apiClient: Get.find()));
  Get.lazyPut(() => ParcelRepo(apiClient: Get.find()));
  Get.lazyPut(() => RideRepo(apiClient: Get.find()));
  Get.lazyPut(() => SetMapRepo(apiClient: Get.find()));
  Get.lazyPut(() => PaymentRepo(apiClient: Get.find()));

  // Controller
  Get.lazyPut(() => ConfigController(configRepo: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => OnBoardController());
  Get.lazyPut(() => FAuthController(
      authRepo:
          FAuthRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
  Get.lazyPut(() => ActivityController());
  // Get.lazyPut(() => ActivityController(activityRepo: ActivityRepo( )));
  // Get.lazyPut(() => ActivityController(activityRepo: ActivityRepo(apiClient: Get.find())));
  Get.lazyPut(() => UserController(userRepo: UserRepo(apiClient: Get.find())));
  Get.lazyPut(
      () => MessageController(messageRepo: MessageRepo(apiClient: Get.find())));
  Get.lazyPut(() => WalletController(walletRepo: Get.find()));
  Get.lazyPut(() => OfferController(offerRepo: Get.find()));
  Get.lazyPut(() => BannerController(bannerRepo: Get.find()));
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
  Get.lazyPut(() => AddressController(addressRepo: Get.find()));
  Get.lazyPut(() => MapController());
  Get.lazyPut(() => ParcelController(parcelRepo: Get.find()));
  Get.lazyPut(() => SetMapController(setMapRepo: Get.find()));
  Get.lazyPut(() => RideController(rideRepo: Get.find()));
  Get.lazyPut(() => PaymentController(paymentRepo: Get.find()));
  Get.lazyPut(() => BottomMenuController());

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> languageJson = {};
    mappedJson.forEach((key, value) {
      languageJson[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        languageJson;
  }
  return languages;
}
