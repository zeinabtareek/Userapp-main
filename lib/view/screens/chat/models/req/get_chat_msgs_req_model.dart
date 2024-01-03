import '../../../../../pagination/model/main_req_entity.dart';

class GetChatMsgsReqModel
    extends MainPaginateRequestEntity<GetChatMsgsReqModel> {
  final String? chatId;
  bool isComplain;
  GetChatMsgsReqModel(super.reqPage,
      {required this.chatId, this.isComplain = false});

  GetChatMsgsReqModel toComplainType() {
    isComplain = true;
    return this;
  }
}
