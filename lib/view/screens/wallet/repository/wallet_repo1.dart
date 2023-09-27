import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../helper/network/dio_integration.dart';
import '../../../../helper/network/error_handler.dart';
import '../../../../util/app_constants.dart';
import '../model/wallet_model.dart';

class WalletRepository {
  ///TODO fetch wallet api
  final dio = DioUtilNew.dio;

  getAllTransactions() async {
    try {
      // final response = await dio!.get('/api/user/orders?status=pending');
      final response =
          await dio!.get(AppConstants.getAllTransactions); //+status

      debugPrint('######${response.data}');
      if (response.statusCode == 200) {
        final model = WalletModel.fromJson(response.data);
        return model;
        // return model.data;
      } else {
        throw UnimplementedError();
      }
    } catch (e) {
      if (e is DioExceptionType) {
        HandleError.handleExceptionDio(e);
      }
      throw UnimplementedError();
    }
  }
}
