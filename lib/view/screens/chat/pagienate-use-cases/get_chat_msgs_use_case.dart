import 'package:get/get.dart';

import '../../../../authenticate/data_state.dart';
import '../../../../helper/network/dio_integration.dart';
import '../../../../pagination/model/pagination_api_model.dart';
import '../../../../pagination/use-case/main_paginate_list_use_case.dart';
import '../constants/chat_constant.dart';
import '../controller/chat_controller.dart';
import '../models/req/get_chat_msgs_req_model.dart';
import '../models/res/msg_chat_res_model_item.dart';

class GetChatMsgsUseCase
    implements
        NetWorkPaginateListUseCase<MsgChatResModelItem, GetChatMsgsReqModel> {
  @override
  GetChatMsgsReqModel? req;

  GetChatMsgsUseCase(this.req);

  @override
  Future<DataState<(PaginationApiModel, List<MsgChatResModelItem>)>> call(
      {GetChatMsgsReqModel? parm}) async {
    final res = await DioUtilNew.dio!.get(
      "${ChatConstant.postSendMsg}/${req!.chatId}",
      queryParameters: {
        ...req?.toMap() ?? {},
      },
    );
    if (res.data['status'] == 200) {
      // PaginationApiModel paginationApiModel =
      //     PaginationApiModel.fromJson(res.data['meta']);

      List<MsgChatResModelItem> list = <MsgChatResModelItem>[];

      // List.from(res.data['data'])
      //     .map((data) => MsgChatResModelItem.fromMap(data))
      //     .toList();

      for (var element in res.data['data']["messages"]) {
        list.add(MsgChatResModelItem.fromSingleMsg(element, res.data['data']));
      }
       if (list.isNotEmpty) {
        var controller = Get.find<ChatController>();
        controller.chatId = list.first.order?.id;

        controller.canChat(
          list.first.order?.canChatInOrder ?? false,
        );
      }
      // return DataSuccess((paginationApiModel, list));
      return DataSuccess((PaginationApiModel(), list));
    } else {
      String msg = res.data['message'];
      return DataFailedErrorMsg(msg, null);
    }
  }

  @override
  GetChatMsgsReqModel setPage(int page) {
    req!.reqPage = page;
    return req!;
  }
}
