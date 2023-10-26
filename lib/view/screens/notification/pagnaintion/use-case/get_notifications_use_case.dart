import '../../../../../authenticate/data_state.dart';
import '../../../../../helper/network/dio_integration.dart';
import '../../../../../pagination/model/pagination_api_model.dart';
import '../../../../../pagination/use-case/main_paginate_list_use_case.dart';
import '../../../../../util/app_constants.dart';
import '../../model/notification_res_model.dart';
import '../model/get_notification_req_model.dart';


// get_notifications_use_case
class GetNotificationsUseCase
    implements NetWorkPaginateListUseCase<NotificationModel, GetNotificationReqModel> {
  GetNotificationsUseCase(this.req);

  @override
  GetNotificationReqModel? req = GetNotificationReqModel(1);

  @override
  Future<DataState<(PaginationApiModel, List<NotificationModel>)>> call(
      {GetNotificationReqModel? parm}) async {
    final res = await DioUtilNew.dio!.get(
      AppConstants.getNotification,
      queryParameters: req?.toApiMapQuery,
    );
    if (res.data['status'] == 200) {
      List<NotificationModel> list = [];
      for (Map<String, dynamic> element in res.data['data']) {
        list.add(NotificationModel.fromMap(element));
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
  GetNotificationReqModel setPage(int page) {
    req!.page = page;
    req!.reqPage = page;
    return req!;
  }
}
