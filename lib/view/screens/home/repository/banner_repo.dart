import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/banner_model.dart';

import '../../../../helper/network/dio_integration.dart';
import '../../../../util/app_constants.dart';

class BannerRepo {
  final ApiClient apiClient;

  BannerRepo({required this.apiClient});
  final dio = DioUtilNew.dio;
  // Future<Response> getBannerList() async {
  //   List<BannerModel> bannerList = [];
  //   try {
  //     bannerList = [
  //       // BannerModel(
  //       //     bannerImage:
  //       //         "https://www.shutterstock.com/image-vector/summer-ad-sale-banner-popart-260nw-1458893918.jpg",
  //       //     bannerTitle: ""),
  //       // BannerModel(
  //       //   bannerImage:
  //       //       "https://www.shutterstock.com/image-vector/summer-ad-sale-banner-popart-260nw-1458893918.jpg",
  //       //   bannerTitle: "",
  //       // ),
  //       // BannerModel(
  //       //   bannerImage:
  //       //       "https://www.shutterstock.com/image-vector/summer-ad-sale-banner-popart-260nw-1458893918.jpg",
  //       //   bannerTitle: "",
  //       // ),
  //       // BannerModel(
  //       //   bannerImage:
  //       //       "https://www.shutterstock.com/image-vector/summer-ad-sale-banner-popart-260nw-1458893918.jpg",
  //       //   bannerTitle: "",
  //       // )
  //     ];
  //     Response response = Response(body: bannerList, statusCode: 200);
  //     return response;
  //   } catch (e) {
  //     return const Response(
  //         statusCode: 404, statusText: 'on boarding data not found');
  //   }
  // }
  Future<(BannerModel, num)> getSlider() async {
    //  List<BannerData>? data;

    try {
      final response = await dio!.get(AppConstants.getSlider);

      debugPrint('####getSlider${response.data}');
      if (response.statusCode == 200) {
        final model = BannerModel.fromJson(response.data);
        final unReadCount = response.data['unread_count'] as num;
        return (model,unReadCount);
      } else {
        throw UnimplementedError();
      }
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }
}
