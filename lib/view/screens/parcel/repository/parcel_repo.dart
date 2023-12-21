import 'package:ride_sharing_user_app/authenticate/data/models/model.dart';
import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:dio/dio.dart' as dm show FormData;
import 'package:ride_sharing_user_app/view/screens/history/model/history_model.dart';

import '../../../../helper/network/dio_integration.dart';
import '../../../../util/action_center/exceptions.dart';
import '../../../../util/app_constants.dart';
import '../model/create_parcel_body.dart';
import '../model/create_parcel_response.dart';

class ParcelRepo {
  final dio = DioUtilNew.dio;

  Future<CreateParcelModel> createAParcel(
      {required CreateParcelBody createParcelBody}) async {
    final data = createParcelBody.toJson();

    final res = await dio!.post(
      AppConstants.order,
      data: dm.FormData.fromMap(data),
    );
    print('res ::${res.statusCode}');
    print('res ::${res.data}');
    if (res.statusCode == 200) {
      if (res.data != null) {
        final model = CreateParcelModel.fromJson(res.data);
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

  Future<HistoryData> showOrderById(String id) async {
    try {
      final res = await dio!.get(
        "${AppConstants.order}/${id.toString()}",
      );

      if (res.statusCode == 200) {
        // if (true) {
        if (res.data != null) {
          // final model = HistoryData.fromJson({
          //   "id": "bae6054f-2430-4fcf-bdb9-f91f87b019ba",
          //   "order_num": "bae60",
          //   "from": {
          //     "lat": "21.23443",
          //     "lng": "23.32323",
          //     "location": "Nasr City"
          //   },
          //   "to": {
          //     "lat": "21.23443",
          //     "lng": "23.32323",
          //     "location": "Nasr City"
          //   },
          //   "status": "parcel_delivered",
          //   "status_times": [
          //     {"status": "pending", "time": "2023-11-25 12:47:25"},
          //     {"status": "driver_accept", "time": "2023-11-25 20:48:16"},
          //     {"status": "parcel_picked", "time": "2023-11-25 21:12:05"},
          //     {"status": "arrived_drop_point", "time": "2023-11-25 21:12:39"},
          //     {"status": "parcel_delivered", "time": "2023-11-25 21:12:44"}
          //   ],
          //   "distance": 10,
          //   "time": 10,
          //   "payment_type": "wallet",
          //   "transaction_id": null,
          //   "note": "lorem ipsum",
          //   "extra_routes": null,
          //   "google_route": [
          //     {"lat": "21.123", "lng": "21.124"},
          //     {"lat": "21.123", "lng": "21.124"},
          //     {"lat": "21.123", "lng": "21.124"}
          //   ],
          //   "is_parcel": true,
          //   "parcel_details": {
          //     "sender_number": "0109382738",
          //     "sender_name": "ahmed",
          //     "receiver_number": "0199383987",
          //     "receiver_name": "ali",
          //     "parcel_name": "books",
          //     "parcel_dimension": "12*12*9",
          //     "parcel_weight": "1.7 kg",
          //     "how_pay": null,
          //     "parcel_category": {
          //       "id": "2e815b70-6c96-485c-91f0-2ee45f49205e",
          //       "name": "صندوق",
          //       "img":
          //           "http://arabchance.com/Hood-Backend-Dashboard/public/default/place_holder.jpg",
          //       "created_at": "2023-10-17 10:04:19"
          //     }
          //   },
          //   "package": {
          //     "id": "9571cdde-45fc-4501-9538-82ac88c5b397",
          //     "name": "بضائع",
          //     "img":
          //         "http://arabchance.com/Hood-Backend-Dashboard/public/default/place_holder.jpg",
          //     "km_price": 120,
          //     "is_parcel": true,
          //     "has_child": false,
          //     "is_active": true
          //   },
          //   "vehicle_type": null,
          //   "promo_code": null,
          //   "driver": {
          //     "id": "8a0e1dc5-a448-4201-8178-4db36f87c2f9",
          //     "phone_code": "+966",
          //     "phone": "123456784",
          //     "email": "ahmedMohamed@gmail.com",
          //     "img":
          //         "http://arabchance.com/Hood-Backend-Dashboard/public/storage/files/uploads/driver/img/img_hood_1700128367_@2023.jpg",
          //     "first_name": "111",
          //     "last_name": "Mohamed",
          //     "vehicle": {
          //       "id": 17,
          //       "type": "هاتش باك",
          //       "brand": "هوندا",
          //       "model": "فيرنا",
          //       "factory_year": {
          //         "id": "5fab7bbb-a209-4e26-9d7a-b4f1c015fd0f",
          //         "name": "2023"
          //       },
          //       "color": {
          //         "id": "97f477a4-7361-42fb-b149-2099f2119b4b",
          //         "name": "أسود"
          //       },
          //       "license_image":
          //           "http://arabchance.com/Hood-Backend-Dashboard/public/storage/files/uploads/vehicle/img/scaled_2ff2aa21-25f9-4d80-ab79-35b418458c6d4489057796306083423_hood_1699878507_@2023.jpg",
          //       "img":
          //           "http://arabchance.com/Hood-Backend-Dashboard/public/storage/files/uploads/vehicle_model/img/Screenshot_from_2023-11-05_14-45-17_hood_1699365168_@2023.png"
          //     }
          //   },
          //   "km_price": 120,
          //   "price_before_discount": 1200,
          //   "promo_code_used": false,
          //   "discount_percent": 0,
          //   "final_price": 1200,
          //   "discount_amount": 0,
          //   "tip": 0,
          //   "driver_amount": 1200,
          //   "created_at": "2023-11-25 12:47:25"
          // });

          final model = HistoryData.fromJson(res.data['data']);
          return model;
        }
      } else if (res.statusCode == 422) {
        // } else if (false) {
        throw CustomException(res.data['message'], description: 'test 422');
        // throw CustomException("res.data['message']", description: 'test 422');
      } else {
        throw ApiResponseException(res.statusCode!);
        // throw ApiResponseException(200);
      }
    } on Exception catch (e) {
      print(" Exception $e ");
      rethrow;
    }

    throw Exception("Unexpected error occurred");
  }
}
