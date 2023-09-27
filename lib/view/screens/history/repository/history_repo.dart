import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/activity_item_model.dart';

import '../../../../helper/network/dio_integration.dart';
import '../../../../helper/network/error_handler.dart';
import '../../../../util/app_constants.dart';
import '../model/history_model.dart';

class HistoryRepo {



  final dio = DioUtilNew.dio;
  ///Apis fetch history and support

   getAllHistory({status}) async {
    try {
      // final response = await dio!.get('/api/user/orders?status=pending');
      final response = await dio!.get(AppConstants.getAllHistory+status);//+status

      debugPrint('######${response.data }');
      if (response.statusCode == 200) {
        final model = HistoryModel.fromJson(response.data);
        return model.data;
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
