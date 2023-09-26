import 'package:flutter/widgets.dart';

class ScreenObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    // Handle screen navigation here
    final currentScreen = route.settings.name;
    debugPrint('Current Screen::::: $currentScreen');
  }
}
