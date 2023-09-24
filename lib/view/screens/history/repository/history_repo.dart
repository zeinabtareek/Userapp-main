import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/activity_item_model.dart';

import '../../../../helper/network/dio_integration.dart';
import '../../../../helper/network/error_handler.dart';
import '../../../../util/app_constants.dart';
import '../model/history_model.dart';

class ActivityRepo {
  // final ApiClient apiClient;
  // ActivityRepo({required this.apiClient});

  final dio = DioUtilNew.dio;

  // Future<Response> getActivityList() async {
  //   List<ActivityItemModel> activityItemList = [];
  //   // List<HistoryData> activityItemList = [];
  //   try {
  //     activityItemList = [
  //       ActivityItemModel(
  //           image: Images.bike, vachelType: 'bike',orderStatus: 'completed',title: "Mirpur Dohs, Dhaka,Bangldesh",orderAmount: 3553,date: "2022-09-14T13:49:51.000000Z",
  //         tripDetails: TripDetails(
  //           pickLocation: "52 Bedok Reservoir Cres Singapore 479226",
  //           destination: "Bidadari Park Drive Singapore - 1 Wallich St Singapore",
  //           totalDistance: 12.2,
  //           farePrice: 120,
  //           paymentMethod: "Cash"
  //         ),
  //         riderDetails: RiderDetails(
  //           name: "Jhone Doe",
  //           image: "",
  //           rating: 4.8,
  //           vehicleName: "Pulser 150 cc",
  //           vehicleType: "bike",
  //           vehicleNumber: "DH 123-27-56"
  //
  //         )
  //       ),
  //
  //       ActivityItemModel(
  //           image: Images.car, vachelType: 'car',orderStatus: 'canceled',title: "Mirpur Dohs, Dhaka,Bangldesh",date: "2022-09-14T13:49:51.000000Z"),
  //       ActivityItemModel(
  //           image: Images.bike, vachelType: 'bike',orderStatus: 'canceled',title: "Dhanmondi, Dhaka,Bangldesh",date: "2022-09-14T13:49:51.000000Z"),
  //
  //       ActivityItemModel(
  //           image: Images.bike, vachelType: 'bike',orderStatus: 'ongoing',title: "Mirpur Dohs, Dhaka,Bangldesh",orderAmount: 276,date: "2022-09-14T13:49:51.000000Z"),
  //       ActivityItemModel(
  //           image: Images.car, vachelType: 'car',orderStatus: 'completed',title: "Mirpur Dohs, Dhaka,Bangldesh",orderAmount: 354,date: "2022-09-14T13:49:51.000000Z"),
  //       ActivityItemModel(
  //           image: Images.bike, vachelType: 'bike',orderStatus: 'canceled',title: "Dhanmondi, Dhaka,Bangldesh",date: "2022-09-14T13:49:51.000000Z"),
  //     ];
  //
  //     Response response = Response(body: activityItemList, statusCode: 200);
  //     return response;
  //   } catch (e) {
  //     return const Response(
  //         statusCode: 404, statusText: 'on boarding data not found');
  //   }
  // }

  ///Apis fetch
  Future<HistoryModel> getAllHistoryTrips() async {
    try {
      final response = await dio!.get(AppConstants.getAllOrders);

      debugPrint('######${response.data['data']}');
      if (response.statusCode == 200) {
        HistoryModel model = HistoryModel.fromJson(response.data);
        return model;
      } else {
        throw UnimplementedError();
      }
    } catch (e) {
      if (e is DioExceptionType) {
        HandleError.handleExceptionDio(e);
      }
      throw UnimplementedError();
    }
  }
}
