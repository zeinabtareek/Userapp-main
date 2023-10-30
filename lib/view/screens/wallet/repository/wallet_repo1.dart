import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../helper/network/dio_integration.dart';
import '../../../../helper/network/error_handler.dart';
import '../../../../pagination/typedef/page_typedef.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../dashboard/dashboard_screen.dart';
import '../model/wallet_model.dart';

class WalletRepository {
  ///TODO fetch wallet api
  final dio = DioUtilNew.dio;

  // getAllTransactions() async {
  //   try {
  //     // final response = await dio!.get('/api/user/orders?status=pending');
  //     final response =
  //         await dio!.get(AppConstants.getAllTransactions); //+status
  //
  //     debugPrint('######${response.data}');
  //     if (response.statusCode == 200) {
  //       final model = WalletModel.fromJson(response.data);
  //       return model;
  //       return model.data;
  //     }
  //
  //     else {
  //       throw UnimplementedError();
  //     }
  //   } catch (e) {
  //     if (e is DioExceptionType) {
  //       HandleError.handleExceptionDio(e);
  //     }
  //     throw UnimplementedError();
  //   }
  // }


  withdrawWallet({ required int amount,note, transactionId})async{
      try {
        final response = await dio!.post(AppConstants.withdrawWallet,
            data: {
              'amount':amount,
              'note':note,
              'transaction_id':transactionId
            }
        );
        debugPrint('######${response.data}');
        if (response.statusCode == 200) {
          print('response.statusCode ${response.statusCode}');
          OverlayHelper.showSuccessToast(Get.overlayContext!,response.data['message'].toString());
          await  Get.find<PaginateAllTransactionsController>()..onRefreshData();

          Get.back(result:true );
          print(response);
        }
        else  if(response.statusCode == 422){
          OverlayHelper.showErrorToast(Get.overlayContext!, response.data['message'].toString());
        }
        else {
          throw UnimplementedError();
        }
      } catch (e) {
        print(e);
        throw UnimplementedError();
      }
    }
  chargeWallet({ required int amount,  transactionId})async{
    try {
      final response = await dio!.post(AppConstants.chargeWallet,
          data: {
            'amount':amount,

            'transaction_id':transactionId
          }
      );
      debugPrint('######${response.data}');
      if (response.statusCode == 200) {
        print('response.statusCode ${response.statusCode}');
        OverlayHelper.showSuccessToast(Get.overlayContext!,response.data['message'].toString());
        await  Get.find<PaginateAllTransactionsController>()..onRefreshData();
        Get.back(result:true );
        print(response);
      }
      else  if(response.statusCode == 422){
        OverlayHelper.showErrorToast(Get.overlayContext!, response.data['message'].toString());
      }
      else {
        throw UnimplementedError();
      }
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }


    // print('response.statusCode ${response.statusCode}');
  }
}
