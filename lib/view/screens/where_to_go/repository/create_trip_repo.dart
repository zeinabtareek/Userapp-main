import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/where_to_go_screen.dart';

import '../../../../enum/request_states.dart';
import '../../../../helper/network/dio_integration.dart';
import '../../../../util/action_center/exceptions.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/app_strings.dart';
import '../../request_screens/controller/base_map_controller.dart';
import '../../request_screens/model/order_model.dart';
import '../model/create_order_body.dart';
import '../model/order_create.dart';

class CreateTripRepo {

  final dio = DioUtilNew.dio;
  createATrip({required CreateOrderBody createOrderBody}) async {

     final data = createOrderBody.toJson();

    final res = await dio!.post(
      AppConstants.order,
      data: data,
    );
    print('res ::${res.statusCode}');
    print('res ::${res.data}');
    if (res.statusCode == 200) {
      if (res.data != null) {
        final model = CreateOrderModel.fromJson(res.data);
        print('model ${model.data?.id??''}');
        return model;
      }
    } else if (res.statusCode == 422) {
      throw CustomException(res.data['message'], description: '');
    } else {
      throw ApiResponseException(res.statusCode!);
    }

    throw Exception("Unexpected error occurred");
    }
  cancelATrip({orderId})async{
    final res = await dio!.post(
      '${AppConstants.order+"/"+orderId}/${Strings.cancel}',
    );
    print('res ::${res.statusCode}');
    print('res ::${res.data}');
    if (res.statusCode == 200) {
      if (res.data != null) {
         print('cancel response ${res.data ??''}');
         Get.offAll(SetDestinationScreen(fromCat: false));
        return res.data ;
      }
    } else if (res.statusCode == 422) {
      throw CustomException(res.data['message'], description: '');
    } else {
      throw ApiResponseException(res.statusCode!);
    }

    throw Exception("Unexpected error occurred");
  }
  showTripDetails({orderId})async{

    final res = await dio!.get(
      '${AppConstants.order}/'+orderId,
    );
    print('res ::${res.statusCode}');
    print('res ::${res.data}');
    if (res.statusCode == 200) {
      if (res.data != null) {
        final model = OrderModel.fromJson(res.data);
        print('model ${model.data?.id??''}');

        Get.find<BaseMapController>(). key.currentState!.expand();
        Get.find<BaseMapController>().changeState(request[RequestState.driverAcceptState]!);

        ///here change state zeinab  to driver accept
        return model;
      }
    } else if (res.statusCode == 422) {
      throw CustomException(res.data['message'], description: '');
    } else {
      throw ApiResponseException(res.statusCode!);
    }

    throw Exception("Unexpected error occurred");

  }
}
