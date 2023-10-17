import 'package:ride_sharing_user_app/helper/network/dio_integration.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';

import '../../authenticate/data/models/base_model.dart';
import '../../genral-models/vehicle_type.dart';

/// to use it just write `GetVehicleTypesUseCase(packageId as String)` or if put it in di container first
/// use `Get.find<GetVehicleTypesUseCase>(packageId as String).call()`
// get_vehicle_types_by_package_id_use_case
class GetVehicleTypesByPackageIdUseCase {
  String packageId;

  GetVehicleTypesByPackageIdUseCase(this.packageId);
  Future<List<VehicleType>> call() async {
    final res = await DioUtilNew.dio!.get(
      ' /$packageId',
      // '${AppConstants.vehicleTypesByPackageId}/$packageId',
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
