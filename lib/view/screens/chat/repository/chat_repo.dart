import 'package:dio/dio.dart';

import '../../../../authenticate/data/models/base_model.dart';
import '../../../../helper/network/dio_integration.dart';
import '../constants/chat_constant.dart';
import '../models/req/send_msg_req_model.dart';
import '../models/res/msg_chat_res_model_item.dart';

class ChatRepo {
  ChatRepo();

  // Future<List> show(String chatId) async {
  //   // TODO:
  //   return [];
  // }

  Future<MsgChatResModelItem> sendMsg(
    SendMsgReqModel req,
  ) async {
    try {
      final res = await DioUtilNew.dio!.post(ChatConstant.postSendMsg,
          data: FormData.fromMap(await req.toMap()));
      if (res.data['status'] == 200) {
        return MsgChatResModelItem.fromMap(res.data);
      } else {
        throw MsgModel.fromJson(res.data);
      }
    } on Exception {
      throw MsgModel().copyWith(massage: "Exception");
    }
  }
}
