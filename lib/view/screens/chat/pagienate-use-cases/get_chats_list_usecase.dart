import 'package:get/instance_manager.dart';

import '../../../../authenticate/data_state.dart';
import '../../../../helper/network/dio_integration.dart';
import '../../../../pagination/model/pagination_api_model.dart';
import '../../../../pagination/use-case/main_paginate_list_use_case.dart';
import '../constants/chat_constant.dart';
import '../controller/chat_controller.dart';
import '../models/req/get_chat_req_model.dart';
import '../models/res/msg_chat_res_model_item.dart';

class GetChatsListOrdersUseCase
    implements
        NetWorkPaginateListUseCase<MsgChatResModelItem, GetChatReqModel> {
  @override
  GetChatReqModel? req = GetChatReqModel(1);
  @override
  Future<DataState<(PaginationApiModel, List<MsgChatResModelItem>)>> call(
      {GetChatReqModel? parm}) async {
    final res = await DioUtilNew.dio!.get(
      ChatConstant.postSendMsg,
      queryParameters: {
        ...req?.toMap() ?? {},
        ...req?.chatTypeToOrder ?? {},
      },
    );
    if (res.data['status'] == 200) {
      PaginationApiModel paginationApiModel =
          PaginationApiModel.fromJson(res.data['meta']);

      List<MsgChatResModelItem> list = <MsgChatResModelItem>[];

      // List.from(res.data['data'])
      //     .map((data) => MsgChatResModelItem.fromMap(data))
      //     .toList();

      for (var element in res.data['data']) {
        list.add(MsgChatResModelItem.fromMap(element));
      }
     
      return DataSuccess((paginationApiModel, list));
    } else {
      String msg = res.data['message'];
      return DataFailedErrorMsg(msg, null);
    }
  }

  @override
  GetChatReqModel setPage(int page) {
    req!.reqPage = page;
    return req!;
  }
}

class GetChatsListAdminUseCase
    implements
        NetWorkPaginateListUseCase<MsgChatResModelItem, GetChatReqModel> {
  @override
  GetChatReqModel? req = GetChatReqModel(1);
  @override
  Future<DataState<(PaginationApiModel, List<MsgChatResModelItem>)>> call(
      {GetChatReqModel? parm}) async {
    final res = await DioUtilNew.dio!.get(
      ChatConstant.postSendMsg,
      queryParameters: {
        ...req?.toMap() ?? {},
        ...req?.chatTypeToAdmin ?? {},
      },
    );
    if (res.data['status'] == 200) {
      PaginationApiModel paginationApiModel =
          PaginationApiModel.fromJson(res.data['meta']);

      List<MsgChatResModelItem> list = <MsgChatResModelItem>[];

      // List.from(res.data['data'])
      //     .map((data) => MsgChatResModelItem.fromMap(data))
      //     .toList();

      for (var element in res.data['data']) {
        list.add(MsgChatResModelItem.fromMap(element));
      }

      return DataSuccess((paginationApiModel, list));
    } else {
      String msg = res.data['message'];
      return DataFailedErrorMsg(msg, null);
    }
  }

  @override
  GetChatReqModel setPage(int page) {
    req!.reqPage = page;
    return req!;
  }
}
