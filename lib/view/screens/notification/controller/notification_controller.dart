import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController
    with GetTickerProviderStateMixin {
  // final NotificationRepo notificationRepo;
  NotificationController();

  late TabController tabController;

  RxInt  viewIndex = 0.obs;

  RxBool get isShowActivity => (viewIndex.value == 0).obs;
  RxBool get isShowOffer => (viewIndex.value == 1).obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }
}
