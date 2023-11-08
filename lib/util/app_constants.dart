import 'package:get/get.dart';

import '../localization/language_model.dart';
import 'images.dart';

class AppConstants {
  static const String appName = 'Hood';
  static const bool isDevelopment = true;

  // static const String baseUrl = 'https://arabchance.com/Hood-Backend-Dashboard/public';
  // static const String baseUrl = 'http://172.16.13.22:8000';

  static const String baseUrl =
      'https://arabchance.com/Hood-Backend-Dashboard/public';

  // static const String baseUrl = 'http://hoodbackend.develobug.com';
  static const String getAllOrders = '/api/user/orders';
  static const String getAllHistory = '/api/user/orders?status=';
  static const String getAllTransactions = '/api/user/all_transactions';
  static const String getNotification = '/api/user/notifications';

  static const String getComplainTypes = '/api/user/complain_types';

  ///****************
  static const String configUri = '/api/v1/config';
  static const String loginUri = '/api/v1/auth/login';
  static const String notificationUri = '/api/v1/customer/notifications';
  static const String getAllSettingUri = '/api/user/all_setting';
  static const String packagesDetails = "/api/user/packages_details";
  static const String packages = "/api/user/packages";
  static const String parcelCategories = "/api/user/parcel_categories";
  static const String postComplains = "/api/user/complains";

  ///zeinab working on now
  static const String getAddress = "/api/user/addresses";
  static const String getAddressSuggestions = "/api/user/address_suggestions";
  static const String order = "/api/user/orders";
  static const String getOrderPrice = "/api/user/orders/order_price";
  static const String getSlider = "/api/user/sliders";
  static String updateProfile = "/api/user/update_profile";

  static const String changePaymentType = "/api/user/change_payment_type";
  static const String withdrawWallet = "/api/user/withdraw";
  static const String chargeWallet = "/api/user/charge";
  // static const String chargeWallet = "/api/driver/points_to_money";
  // static const String cancelTrip = "/api/user/orders/";

  static const profileDetails = "/api/user/profile_details";

  // Shared Key
  static const String notification = 'demand_notification';
  static const String theme = 'theme';
  static const String token = 'token';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String cartList = 'cart_list';
  static const String userPassword = 'user_password';
  static const String userAddress = 'user_address';
  static const String userNumber = 'user_number';
  static const String searchAddress = 'search_address';
  static const String localization = 'X-Localization';
  static const String acceptLanguage = 'Accept-Language';
  static const String topic = 'notify';
  static const String signUpBody = 'signUpBody';
  static const String intro = 'intro';
// error handling

  static const String sendFailure = 'sendFailure';
  static const String unauthorized = 'unauthorized';
  static const String notFoundUrl = 'notFoundUrl';
  static const String notHasAuthorized = 'notHasAuthorized';
  static const String signError = 'signError';
  static const String serverFailure = 'serverFailure';

//map api key

  static const String mapKey = 'AIzaSyBvK3ADi17SjO55E46KGr2RT5vSj2nyRpI';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.unitedKingdom,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.saudi,
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];

  static const int limitOfPickedIdentityImageNumber = 2;
  static const double limitOfPickedImageSizeInMB = 2;

  static List<Map<String, String>> onBoardPagerData = [
    {
      "text": 'on_boarding_1_title'.tr,
      "image": "assets/image/on_board_one.png"
    },
    {
      "text": 'on_boarding_2_title'.tr,
      "image": "assets/image/on_board_two.png"
    },
    {
      "text": 'on_boarding_3_title'.tr,
      "image": "assets/image/on_board_three.png"
    },
    {
      "text": 'on_boarding_4_title'.tr,
      "image": "assets/image/on_board_four.png"
    }
  ];

// static double pinVisiblePositions=20;
// static double pinInVisiblePositions=-300;
}
