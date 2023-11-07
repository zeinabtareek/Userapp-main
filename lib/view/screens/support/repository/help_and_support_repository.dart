import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/support_model.dart';
import 'package:ride_sharing_user_app/view/screens/support/model/complain_res_model.dart';

import '../../../../helper/network/dio_integration.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/ui/overlay_helper.dart';

class HelpAndSupportRepo {
  final dio = DioUtilNew.dio;

  ///Apis fetch help and support
  Future<SupportModel> getAllSettings() async {
    try {
      final response = await dio!.get(AppConstants.getAllSettingUri);

      debugPrint('######${response.data}');
      if (response.statusCode == 200) {
        SupportModel model = SupportModel.fromJson(response.data);
        return model;
      } else {
        throw UnimplementedError();
      }
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }

  submitComplain({message,complainTypeId}) async {
    try {
      final response = await dio!.post(AppConstants.postComplains, data: {
       "complain_type_id":complainTypeId,
        'message': message,
      });

      debugPrint('######${response.data}');
      if (response.statusCode == 200) {
        // SupportModel model =  SupportModel.fromJson(response.data);
        // return model;
        OverlayHelper.showSuccessToast(
            Get.overlayContext!, 'complaint_sent'.tr);
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

  getComplainTypes() async {
    try {
      final response = await dio!.get(AppConstants.getComplainTypes);

      debugPrint('######${response.data}');
      if (response.statusCode == 200) {
        List<dynamic> list = response.data['data'];
        List<ComplainResModel> complains = [];
        for (var item in list) {
          ComplainResModel complain = ComplainResModel.fromMap(item);
          complains.add(complain);
        }
        return complains;
      } else {
        throw UnimplementedError();
      }
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }
}
