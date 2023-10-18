import '../../../../helper/network/dio_integration.dart';
import '../../../../util/action_center/exceptions.dart';
import '../../../../util/app_constants.dart';
import '../model/create_order_body.dart';
import '../model/order_create.dart';

class CreateTripRepo {

  final dio = DioUtilNew.dio;
//   createTrip() async {
// //createATrip
//
//
//   }
//CreateOrderModel

  // Future<CreateOrderModel>
  createATrip({required CreateOrderBody createOrderBody}) async {

    // try{
    final data = createOrderBody.toJson();

    final res = await dio!.post(
      AppConstants.createATrip,
      data: data,
    );
    print('res ::${res.statusCode}');
    print('res ::${res.data}');
    // if (res.statusCode == 200) {
      // if (res.data != null) {
        final model = CreateOrderModel.fromJson(res.data);
        print('model ${model.data?.id??''}');
        return model;
      // }
    // } else if (res.statusCode == 422) {
    //   throw CustomException(res.data['message'], description: '');
    // } else {
    //   throw ApiResponseException(res.statusCode!);
    // }

    throw Exception("Unexpected error occurred");
    }
}
