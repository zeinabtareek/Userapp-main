import 'dart:math';

import 'package:get/get.dart';
import 'package:ride_sharing_user_app/authenticate/data/models/base_model.dart';
import 'package:ride_sharing_user_app/controller/base_controller.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';
import 'package:ride_sharing_user_app/main_use_case/get_packages_details_use_case.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/categoty_model.dart';
import 'package:ride_sharing_user_app/view/screens/home/repository/category_repo.dart';

import '../../../../util/ui/overlay_helper.dart';

class CategoryController extends BaseController implements GetxService {
 

  List<CategoryModel> categoryList = [];
  int heightOfTypes = 0;
  Future<void> getCategoryList() async {
    try {
      final state = actionCenter.execute(
        () async {
          setState(ViewState.busy);
          var lis = await GetPackagesDetailsUseCase().call();
          if (lis.isNotEmpty) {
            for (var element in lis) {
              categoryList.add(CategoryModel.fromVehicleType(element));
            }
            setState(ViewState.idle);
          } else {
            setState(ViewState.error);
          }
        },
      );
    } on MsgModel catch (e) {
      OverlayHelper.showErrorToast(Get.overlayContext!, e.massage ?? "");
    }
    update();
  }
}
