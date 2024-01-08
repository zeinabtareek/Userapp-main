import 'package:dio/dio.dart' as dm;
import 'package:get/instance_manager.dart';

import '../../../../authenticate/data/models/base_model.dart';
import '../../../../helper/network/dio_integration.dart';
import '../constants/chat_constant.dart';
import '../controller/chat_controller.dart';
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
      final res = await DioUtilNew.dio!.post(
        ChatConstant.postSendMsg,
        data: dm.FormData.fromMap(
          await req.toMap(),
        ),
      );
      if (res.data['status'] == 200) {
        var msg = MsgChatResModelItem.fromMap(res.data['data']);

        if (Get.find<ChatController>().chatId.value == null) {
         
          Get.find<ChatController>().setChatId(msg.id.toString());

          // ignore: avoid_single_cascade_in_expression_statements
        }
        return msg;
      } else {
        throw MsgModel.fromJson(res.data);
      }
    } on Exception {
      throw MsgModel().msg= "Exception";
    }
  }
}
