import '../../../../authenticate/data/models/base_model.dart';
import '../../../../helper/network/dio_integration.dart';
import '../../../../util/app_constants.dart';

class CheckRegionUseCase {
  Future<BaseResModel<MsgModel>> call(double lat, double lng) async {
    try {
      final res = await DioUtilNew.dio!.get(
        AppConstants.checkRegin,
        queryParameters: {
          "lat": lat,
          "lng": lng,
        },
      );

      return MsgModel.fromJson(res.data);
    } catch (e) {
      throw AssertionError(e.toString());
    }
  }
}
