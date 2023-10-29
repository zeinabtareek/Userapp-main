// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ride_sharing_user_app/authenticate/data/models/res-models/user_model.dart';
import 'package:ride_sharing_user_app/view/screens/chat/constants/chat_constant.dart';
import 'package:ride_sharing_user_app/view/screens/chat/models/res/msg_chat_res_model_item.dart';

enum MsgType {
  text,
  image,
  file,
  voice,
}

//  chat_type: "order",
enum ChatType { order, admin }

class SendMsgReqModel {
  String? orderId;
  // String? adminId;
  MsgType? msgType;
  dynamic msg;
  ChatType? chatType;
  SendMsgReqModel({
    this.orderId,
    // this.adminId,
    this.chatType = ChatType.order,
    this.msgType,
    required this.msg,
  }) {
    if (msg is File) {
      msgType = MsgType.image;
    } else {
      msgType = MsgType.text;
    }
  }

  Future<Map<String, dynamic>> toMap() async {
    return <String, dynamic>{
      if (chatType == ChatType.order && orderId != null) 'order_id': orderId,
      // if (adminId != null) 'admin_id': adminId,
      "chat_type": chatType!.name,
      ...{
        if (msg is File) ...{
          'msg': await MultipartFile.fromFile((msg as File).path),
          'msg_type': MsgType.image.name,
        } else ...{
          'msg': msg,
          'msg_type': MsgType.text.name,
        }
      }
    };
  }

  getIdForChat({
    String? orderId,
    // String? adminId,
  }) {
    if (orderId != null) {
      this.orderId = orderId;
    } else {
      chatType = ChatType.admin;
    }
    return this;
  }

  MsgChatResModelItem toMsg(UserAuthModel user) {
    return MsgChatResModelItem(
      isMe: true,
      chatType: chatType!.name,
      msg: msg,
      msgType: msgType,
      createdAt: DateTime.now(),
      readAt: DateTime.now(),
      senderType: ChatConstant.who,
    );
  }
}
