import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkInfo {

static  Future<bool> isConnected(  {bool showToast= true}) async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    bool isConnected= result != ConnectivityResult.none;

    if (!isConnected && showToast) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        backgroundColor:  Colors.red ,
        duration: Duration(seconds: 3),
        content: Text(
          'no_connection' ,
          textAlign: TextAlign.center,
        ),
      ));
    }
    return   isConnected ;
  }

  static void checkConnectivity(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      bool isNotConnected = result == ConnectivityResult.none;
      isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: isNotConnected ? Colors.red : Colors.green,
        duration: Duration(seconds: isNotConnected ? 6000 : 3),
        content: Text(
          isNotConnected ? 'no_connection' : 'connected',
          textAlign: TextAlign.center,
        ),
      ));
    });
  }
}
