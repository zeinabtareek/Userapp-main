import '../../../pagination/model/main_req_entity.dart';

class MainPaginateRequestEntityModel
    extends MainPaginateRequestEntity<MainPaginateRequestEntityModel> {
  int? page;
  MainPaginateRequestEntityModel(this.page, {Map<String, dynamic>? newMap})
      : super(page, map: newMap);

  @override
  Map<String, dynamic> toMap() {
    return {
      "page": page ?? 1,
    };
  }

 
}
