import '../../../../../pagination/model/main_req_entity.dart';

class GetChatMsgsReqModel
    extends MainPaginateRequestEntity<GetChatMsgsReqModel> {
  final String? chatId;
  final String? orderId;
  bool isComplain;
  GetChatMsgsReqModel(
    super.reqPage, {
    this.chatId,
    this.orderId,
    this.isComplain = false,
  });

  bool get isInOrder => orderId != null;

  GetChatMsgsReqModel toComplainType() {
    isComplain = true;
    return this;
  }
}
