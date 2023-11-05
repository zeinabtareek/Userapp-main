import 'package:dio/dio.dart' as dm show FormData ;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ride_sharing_user_app/util/ui/overlay_helper.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/where_to_go_screen.dart';

import '../../../../enum/request_states.dart';
import '../../../../helper/network/dio_integration.dart';
import '../../../../util/action_center/exceptions.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/app_strings.dart';
import '../../request_screens/controller/base_map_controller.dart';
import '../../request_screens/model/order/OrderModel.dart';
import '../model/create_order_body.dart';
import '../model/order_create.dart';

class CreateTripRepo {
  final dio = DioUtilNew.dio;
Future<CreateOrderModel> createATrip({required CreateOrderBody createOrderBody}) async {
    final data = createOrderBody.toJson();

    final res = await dio!.post(
      AppConstants.order,
      data:dm.FormData.fromMap(data),
    );
    print('res ::${res.statusCode}');
    print('res ::${res.data}');
    if (res.statusCode == 200) {
      if (res.data != null) {
        final model = CreateOrderModel.fromJson(res.data);
        print('model ${model.data?.id ?? ''}');

        return model;
      }
    } else if (res.statusCode == 422) {
      throw CustomException(res.data['message'], description: 'test 422');
    } else {
      throw ApiResponseException(res.statusCode!);
    }

    throw Exception("Unexpected error occurred");
  }

  cancelATrip({orderId}) async {
    final res = await dio!.post(
      '${"${AppConstants.order}/" + orderId}/${Strings.cancel}',
    );
    print('res ::${res.statusCode}');
    print('res ::${res.data}');
    if (res.statusCode == 200) {
      if (res.data != null) {
        print('cancel response ${res.data ?? ''}');
        OverlayHelper.showGeneralToast(
            Get.context!, Strings.orderStatus, Strings.orderCanceled);
        Get.offAll(SetDestinationScreen(fromCat: false));
        return res.data;
      }
    } else if (res.statusCode == 422) {
      throw CustomException(res.data['message'], description: '');
    } else {
      throw ApiResponseException(res.statusCode!);
    }

    throw Exception("Unexpected error occurred");
  }

  showTripDetails({orderId}) async {
    final res = await dio!.get(
      '${AppConstants.order}/' + orderId,
    );
    print('res ::${res.statusCode}');
    print('res ::${res.data}');
    if (res.statusCode == 200) {
      if (res.data != null) {
        final model = OrderModel.fromJson(res.data);
        print('model ${model.data?.id ?? ''}');


// TODO:  when driver accept
        Get.find<BaseMapController>().key.currentState!.expand();
        Get.find<BaseMapController>()
            .changeState(request[RequestState.driverAcceptState]!);

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



  changePaymentType({id ,paymentType ,vehicleTypeId,transactionId})async{
    // try {
    //   final response = await dio!.post(AppConstants.getOrderPrice,
    //       data: {
    //         'promo_code':promoCode,
    //         'distance':distance  ,
    //         'vehicle_type_id':vehicleTypeId,
    //         'package_id':packageId,
    //       });
    //
    //   debugPrint('######${response.data }');
    //   if (response.statusCode == 200) {
    //     final model = OrderPriceData.fromJson(response.data['data']);
    //     promoCode!=null??    OverlayHelper.showSuccessToast(Get.overlayContext!, Strings.done.tr);
    //
    //     return model;
    //   } else if (response.statusCode == 422) {
    //     throw CustomException(response.data['message'], description: '');
    //   } else {
    //     throw ApiResponseException(response.statusCode!);
    //   }
    // }      on CustomException catch (e) {
    //
    //   // OverlayHelper.showErrorToast(Get.overlayContext!, e.message);
    //   throw e; // Optionally re-throw the exception
    // }
  }

}
