import '../../../../../pagination/model/main_req_entity.dart';

class GetChatMsgsReqModel
    extends MainPaginateRequestEntity<GetChatMsgsReqModel> {
  final String chatId;
  GetChatMsgsReqModel(
    super.reqPage, {
    required this.chatId,
  });
}
