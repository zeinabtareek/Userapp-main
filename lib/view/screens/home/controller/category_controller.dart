import 'dart:math';

import 'package:get/get.dart';
import 'package:ride_sharing_user_app/authenticate/data/models/base_model.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/main_use_case/get_packages_details_use_case.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/categoty_model.dart';
import 'package:ride_sharing_user_app/view/screens/home/repository/category_repo.dart';

class CategoryController extends GetxController implements GetxService {
  CategoryController();

  List<CategoryModel> categoryList = [];
  int heightOfTypes = 0;
  Future<void> getCategoryList() async {


    try {
      var lis = await GetPackagesDetailsUseCase().call();

      for (var element in lis) {
       
        categoryList.add(CategoryModel.fromVehicleType(element));
      }
    } on MsgModel catch (e) {
      // TODO
    }
    update();
  }
}
