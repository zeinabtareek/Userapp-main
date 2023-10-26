import '../../../../../authenticate/data_state.dart';
import '../../../../../helper/network/dio_integration.dart';
import '../../../../../pagination/model/pagination_api_model.dart';
import '../../../../../pagination/use-case/main_paginate_list_use_case.dart';
import '../../../../util/app_constants.dart';
import '../model/history_model.dart';
import 'model/req/get_trip_req_model.dart';

// notification_activity_paginate_use_case
class GetHistoryTripsUseCase
    implements NetWorkPaginateListUseCase<HistoryData, GetTripReqModel> {
  GetHistoryTripsUseCase(this.req);

  @override
  GetTripReqModel? req = GetTripReqModel(1);

  @override
  Future<DataState<(PaginationApiModel, List<HistoryData>)>> call(
      {GetTripReqModel? parm}) async {
    final res = await DioUtilNew.dio!.get(
        AppConstants.getAllOrders,
        queryParameters: req?.toApiMapQuery,
        );
    if (res.data['status'] == 200) {
      List<HistoryData> list = [];
      for (Map<String, dynamic> element in res.data['data']) {
        list.add(HistoryData.fromJson(element));
      }

      PaginationApiModel paginationApiModel =
          PaginationApiModel.fromJson(res.data['meta']);
      return DataSuccess((paginationApiModel, list));
    } else {
      String msg = res.data['message'];
      return DataFailedErrorMsg(msg, null);
    }
  }

  @override
  GetTripReqModel setPage(int page) {
    req!.page = page;
    req!.reqPage = page;
    return req!;
  }
}
