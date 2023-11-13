import 'package:ride_sharing_user_app/helper/network/dio_integration.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';

class GetAppVersionUseCase {
  Future<String> call() async {
    try {
      // String getAppVersion = '/api/user/app_version';
      var res = await DioUtilNew.dio!.get(AppConstants. getAppVersion);
      return (res.data['data']['app_version']).toString();
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
