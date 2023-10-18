import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';

import '../../../../helper/network/dio_integration.dart';
import '../../../../helper/network/error_handler.dart';
import '../../../../util/action_center/exceptions.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../model/order_price_model.dart';

class RideRepo {
  final ApiClient apiClient;

  RideRepo({required this.apiClient});


  final dio = DioUtilNew.dio;
  ///Apis getPrice
  getPrice({promoCode ,distance ,vehicleTypeId,packageId})async{
       try {
        final response = await dio!.post(AppConstants.getOrderPrice,
        data: {
          'promo_code':promoCode,
          'distance':distance  ,
          'vehicle_type_id':vehicleTypeId,
          'package_id':packageId,
        });

        debugPrint('######${response.data }');
        if (response.statusCode == 200) {
          final model = OrderPriceData.fromJson(response.data['data']);
          OverlayHelper.showSuccessToast(Get.overlayContext!, Strings.done.tr);

          return model;
        } else if (response.statusCode == 422) {
          throw CustomException(response.data['message'], description: '');
        } else {
          throw ApiResponseException(response.statusCode!);
        }
      }      on CustomException catch (e) {

  // OverlayHelper.showErrorToast(Get.overlayContext!, e.message);
  throw e; // Optionally re-throw the exception
  }
  // on MsgModel catch (e) {
  //   OverlayHelper.showWarningToast(Get.overlayContext!, e.toString() ?? "");
  //   throw e; // Optionally re-throw the exception
  // }

  throw Exception("Unexpected error occurred"); // Throw an exception if none of the catch blocks are executed
}

}
