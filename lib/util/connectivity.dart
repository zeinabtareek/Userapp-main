import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
 import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ride_sharing_user_app/util/ui/overlay_helper.dart';
 import '../helper/logger/logger.dart';
import 'app_strings.dart';

class ConnectivityService extends GetxService implements IConnectivityService {
  final AbsLogger _logger;
  @override
  var connectionStatus = 0.obs;
  @override
  bool isConnected = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityService(this._logger);

  @override
  void onInit() {
    super.onInit();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  @override
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e, s) {
      _logger.error(error: "signOut failed", stackTrace: s);
      return;
    }
    return updateConnectionStatus(result);
  }

  @override
  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.mobile:
        connectionStatus.value = 1;
        isConnected = true;
        break;
      case ConnectivityResult.wifi:
        connectionStatus.value = 2;
        isConnected = true;
        break;
      case ConnectivityResult.none:
        OverlayHelper.showWarningToast(
          Get.overlayContext!,
          Strings.noInternet.tr,
        );

        isConnected = false;
        connectionStatus.value = 0;
        break;
      default:
        OverlayHelper.showWarningToast(
          Get.overlayContext!,
          "No internet Connection",
        );
        isConnected = false;
        break;
    }
  }
}

abstract class IConnectivityService {
  Future<void> initConnectivity();
  Future<void> updateConnectionStatus(ConnectivityResult result);
  var connectionStatus;
  bool isConnected = false;
}
