

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/support_model.dart';

import '../../../../helper/network/dio_integration.dart';
import '../../../../helper/network/error_handler.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../model/help_model.dart';

class HelpAndSupportRepo {

  final dio = DioUtilNew.dio;
  ///Apis fetch help and support
  Future< SupportModel> getAllSettings() async {
    try {
      final response = await dio!.get(AppConstants.getAllSettingUri);

      debugPrint('######${response.data}');
      if (response.statusCode == 200) {
         SupportModel model =  SupportModel.fromJson(response.data);
        return model;
      } else {
        throw UnimplementedError();
      }
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }
  submitComplain({message, type})async{
    try {
      final response = await dio!.post(AppConstants.postComplains,
        data: {
        'type':type,
        'message':message,

        }
      );

      debugPrint('######${response.data}');
      if (response.statusCode == 200) {
        // SupportModel model =  SupportModel.fromJson(response.data);
        // return model;
        OverlayHelper.showSuccessToast(Get.overlayContext!, 'complaint_sent'.tr);
        // OverlayHelper.showSuccessToast(Get.overlayContext!, 'we_will_reach_you'.tr);

        Get.offAll(DashboardScreen());
        print(response);
      } else {
        throw UnimplementedError();
      }
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }
}