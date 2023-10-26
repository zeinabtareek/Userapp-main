import '../../../../../pagination/model/main_req_entity.dart';

class GetChatReqModel extends MainPaginateRequestEntity<GetChatReqModel> {
  GetChatReqModel(
    super.reqPage,
  );

  Map<String, dynamic> get chatTypeToOrder => {"chat_type": "order"};

  Map<String, dynamic> get chatTypeToAdmin => {"chat_type": "admin"};
}


