import 'package:get/get.dart';

import '../authenticate/config/config.dart';
import '../view/screens/dashboard/dashboard_screen.dart';
import '../view/screens/home/screens/home_screen.dart';
import '../view/screens/splash/splash_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String home = '/home';

  static getInitialRoute() => initial;
  static getSplashRoute() => splash;
  static getHomeRoute(String name) => '$home?name=$name';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => DashboardScreen()),
    //GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const HomeScreen()),

    ...AuthLib.authPages
  ];
}
