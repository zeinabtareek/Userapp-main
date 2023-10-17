// get_packages_use_case
import '../authenticate/data/models/base_model.dart';
import '../genral-models/vehicle_type.dart';
import '../helper/network/dio_integration.dart';
import '../util/app_constants.dart';

class GetPackagesUseCase {
  Future<List<VehicleType>> call() async {
    final res = await DioUtilNew.dio!.get(
      AppConstants.packages,
    );

    if (res.data["status"] == 200 || res.data["status"] == "sucses") {
      return (res.data['data'] as List)
          .map((e) => VehicleType.fromMap(e))
          .toList();
    } else {
      throw MsgModel.fromJson(res.data);
    }
  }
}


