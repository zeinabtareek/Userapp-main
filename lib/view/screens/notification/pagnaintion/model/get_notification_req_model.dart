import '../../../../../../pagination/model/main_paginate_request_entity_model.dart';

enum NotificationType { activity, offer }

class GetNotificationReqModel extends MainPaginateRequestEntityModel {
  final NotificationType? type;

  GetNotificationReqModel(
    super.page, {
   this.type,
  });

  String filterKey = 'type';

  Map<String, dynamic> get filterMap => {
        filterKey: "${type?.name}",
   
      };



  Map<String, dynamic> get toApiMapQuery {
    return super.toMap()..addAll(filterMap);
  }


}
