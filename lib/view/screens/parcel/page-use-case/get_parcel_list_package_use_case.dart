import '../../../../../authenticate/data_state.dart';
import '../../../../../helper/network/dio_integration.dart';
import '../../../../../pagination/model/pagination_api_model.dart';
import '../../../../../pagination/use-case/main_paginate_list_use_case.dart';
import '../../../../util/app_constants.dart';
import '../../history/model/history_model.dart';
import 'model/req/get_parcel_list_package_req_model.dart';

// get_parcel_list_package_use_case
class GetParcelListPackageUseCase
    implements
        NetWorkPaginateListUseCase<HistoryData, GetParcelListPackageReqModel> {
  GetParcelListPackageUseCase(this.req);

  @override
  GetParcelListPackageReqModel? req = GetParcelListPackageReqModel(1);

  @override
  Future<DataState<(PaginationApiModel, List<HistoryData>)>> call(
      {GetParcelListPackageReqModel? parm}) async {
    final res = await DioUtilNew.dio!.get(
      AppConstants.getParcelListOrders,
      queryParameters: req?.toApiMapQuery,
    );
    if (res.data['status'] == 200) {
      List<HistoryData> list = [];
      for (Map<String, dynamic> element in res.data['data']) {
        list.add(HistoryData.fromJson(element));
      }

      PaginationApiModel paginationApiModel = PaginationApiModel();

      if ((res.data as Map<String, dynamic>).containsKey("meta")) {
        paginationApiModel = PaginationApiModel.fromJson(res.data['meta']);
      }
      return DataSuccess((paginationApiModel, list));
    } else {
      String msg = res.data['message'];
      return DataFailedErrorMsg(msg, null);
    }
  }

  @override
  GetParcelListPackageReqModel setPage(int page) {
    req!.page = page;
    req!.reqPage = page;
    return req!;
  }
}
