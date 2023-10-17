



import '../authenticate/data/models/base_model.dart';
import '../helper/network/dio_integration.dart';
import '../util/app_constants.dart';
import '../view/screens/ride/model/address_model.dart';

// class GetAddressUseCase {
//   Future<List<AddressModel>> call() async {
//     final res = await DioUtilNew.dio!.get(
//       AppConstants.getAddress,
//     );
//
//     if (res.data["status"] == 200 || res.data["status"] == "success") {
//       return (res.data['data'] as List)
//           .map((e) => AddressModel.fromJson(e))
//           // .map((e) => AddressData.fromJson(e))
//           .toList();
//     } else {
//       throw MsgModel.fromJson(res.data);
//     }
//   }
// }
