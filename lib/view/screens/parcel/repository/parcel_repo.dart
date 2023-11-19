import 'package:ride_sharing_user_app/data/api_client.dart';
import 'package:dio/dio.dart' as dm show FormData;

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
}
