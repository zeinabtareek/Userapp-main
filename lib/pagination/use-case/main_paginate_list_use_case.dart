import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../authenticate/data_state.dart';
import '../../util/action_center/action_center.dart';
import '../model/main_req_entity.dart';
import '../model/pagination_api_model.dart';

abstract class MainPaginateListUseCase<E,
    P extends MainPaginateRequestEntity?> {
  P? req;

  P setPage(int page);
  MainPaginateListUseCase(this.req);
  Future<DataState<(PaginationApiModel, List<E>)>> call({P? parm});
}

abstract class NetWorkPaginateListUseCase<E,
        P extends MainPaginateRequestEntity?>
    implements MainPaginateListUseCase<E, P> {
  @override
  P? req;

  @override
  Future<DataState<(PaginationApiModel, List<E>)>> call({P? parm}) async {
    ActionCenter actionCenter = Get.find<ActionCenter>();
    bool netState = await actionCenter.execute(() {}, checkConnection: true);
    if (netState) {
      try {
        return call(parm: parm);
      } catch (e) {
        return DataFailedErrorMsg(
          "e :: ${e.toString()}",
          (PaginationApiModel(), []),
        );
      }
    } else {
      return DataFailedErrorMsg(
          "No internet connection", (PaginationApiModel(), []));
    }
  }
}
