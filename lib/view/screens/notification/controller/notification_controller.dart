import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/helper/date_converter.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:ride_sharing_user_app/view/screens/notification/repository/notification_repo.dart';

class NotificationController extends GetxController  with SingleGetTickerProviderMixin  implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});

  List<NotificationModel>? _notificationList = [];
  late TabController tabController;

  List<NotificationModel>? get notificationList => _notificationListDemo;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);

  }

  Future<void> getNotificationList({bool reload = false}) async {
    if (reload) {
      _notificationList = null;
      update();
    }
    if (_notificationList == null || reload) {
      Response response = await notificationRepo.getNotificationList();
      if (response.statusCode == 200) {
        _notificationList = [];
        //response.body.forEach((notification) => _notificationList?.add(NotificationModel(id: 1, data: Data(title: 't'), createdAt: createdAt, updatedAt: updatedAt)));
        _notificationList?.sort((a, b) {
          return DateConverter.isoStringToLocalDate(a.createdAt)
              .compareTo(DateConverter.isoStringToLocalDate(b.createdAt));
        });
        _notificationList = _notificationList?.reversed.toList();
      } else {
        if (AppConstants.isDevelopment) {
          _notificationList = _notificationListDemo;
        }
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  final List<NotificationModel> _notificationListDemo = [
    NotificationModel(
      id: 1,
      data: Data(title: 'title-one', description: 'Rider canceled the trip'),
      createdAt: '2021-02-05T09:24:15.000000Z',
    ),
    NotificationModel(
        id: 2,
        data: Data(title: 'title-one', description: 'Rider canceled the trip'),
        createdAt: '2021-02-05T09:24:15.000000Z'),
    NotificationModel(
        id: 3,
        data: Data(title: 'title-one', description: 'Rider canceled the trip'),
        createdAt: '2021-02-05T09:24:15.000000Z'),
    NotificationModel(
        id: 4,
        data: Data(title: 'title-one', description: 'Rider canceled the trip'),
        createdAt: '2021-02-05T09:24:15.000000Z'),
    NotificationModel(
        id: 5,
        data: Data(title: 'title-one', description: 'Rider canceled the trip'),
        createdAt: '2021-02-05T09:24:15.000000Z'),
    NotificationModel(
        id: 6,
        data: Data(title: 'title-one', description: 'Rider canceled the trip'),
        createdAt: '2021-02-05T09:24:15.000000Z'),
    NotificationModel(
        id: 7,
        data: Data(title: 'title-one', description: 'Rider canceled the trip'),
        createdAt: '2021-02-05T09:24:15.000000Z'),
    NotificationModel(
        id: 8,
        data: Data(title: 'title-one', description: 'Rider canceled the trip'),
        createdAt: '2021-02-05T09:24:15.000000Z'),
  ];

}

class NotificationModel {
  final int id;
  final Data data;
  final String createdAt;
  NotificationModel(
      {required this.id, required this.data, required this.createdAt});
}

class Data {
  final String title;
  final String description;

  Data({
    required this.title,
    required this.description,
  });
}
