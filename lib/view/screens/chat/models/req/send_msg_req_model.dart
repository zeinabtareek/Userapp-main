// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

enum MsgType {
  text,
  image,
  file,
  voice,
}

class SendMsgReqModel {
  String? orderId;
  // String? adminId;
  MsgType? msgType;
  dynamic msg;
  SendMsgReqModel({
    this.orderId,
    // this.adminId,
    this.msgType,
    required this.msg,
  });

  Future<Map<String, dynamic>> toMap() async {
    return <String, dynamic>{
      if (orderId != null) 'order_id': orderId,
      // if (adminId != null) 'admin_id': adminId,
      "chat_type":"order",
      ...{
        if (msg is XFile) ...{
          'msg': await MultipartFile.fromFile((msg as XFile).path),
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
    }
    return this;
  }
}
