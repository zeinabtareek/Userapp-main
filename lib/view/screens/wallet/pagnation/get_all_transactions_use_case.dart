import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/wallet/controller/wallet_controller.dart';

import '../../../../../authenticate/data_state.dart';
import '../../../../../helper/network/dio_integration.dart';
import '../../../../../pagination/model/pagination_api_model.dart';
import '../../../../../pagination/use-case/main_paginate_list_use_case.dart';
import '../../../../../util/app_constants.dart';
import '../../../../pagination/model/main_paginate_request_entity_model.dart';

import '../model/wallet_model.dart';

class GetAllTransactionsUseCase
    implements
        NetWorkPaginateListUseCase<WalletData, MainPaginateRequestEntityModel> {
  @override
  MainPaginateRequestEntityModel? req = MainPaginateRequestEntityModel(1);

  @override
  Future<DataState<(PaginationApiModel, List<WalletData>)>> call(
      {MainPaginateRequestEntityModel? parm}) async {
    final res = await DioUtilNew.dio!.get(
      AppConstants.getAllTransactions,
      queryParameters: req?.toMap(),
    );
    if (res.data['status'] == 200) {
      List<WalletData> list = [];
      for (Map<String, dynamic> element in res.data['data']) {
        list.add(WalletData.fromJson(element));
      }

      PaginationApiModel paginationApiModel =
          PaginationApiModel.fromJson(res.data['meta']);
      if (list.isNotEmpty) {
  _handelWalletAmount(list.first);
}
      return DataSuccess((paginationApiModel, list));
    } else {
      String msg = res.data['message'];
      return DataFailedErrorMsg(msg, null);
    }
  }

  _handelWalletAmount(WalletData data) {
    if (req!.page == 1 && req!.reqPage == 1) {
      Get.find<WalletController>().refreshAmount(data.walletAfter.toString());
    }
  }

  @override
  MainPaginateRequestEntityModel setPage(int page) {
    req!.page = page;
    req!.reqPage = page;
    return req!;
  }
}
