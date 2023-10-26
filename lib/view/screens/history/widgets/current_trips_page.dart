import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../pagination/typedef/page_typedef.dart';
import '../../../../pagination/widgets/paginations_widgets.dart';
import '../page-use-case/get_history_trips_use_case.dart';
import '../page-use-case/model/req/get_trip_req_model.dart';
import 'activity_item_view.dart';

class CurrentTripsPage extends StatelessWidget {
  final GetTripReqModel req;
  // final RefreshController refreshController;
  const CurrentTripsPage({
    super.key,
    required this. req,
    // required this.refreshController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaginateTripHistoryController>(
        init: PaginateTripHistoryController(
          GetHistoryTripsUseCase(req),
        ),
        builder: (con) {
          return PaginateTripHistoryView(
            listPadding: const EdgeInsets.only(top: 0, bottom: 90),
            child: (entity) =>
                ActivityItemView(data: entity, isDetailsScreen: false),
            paginatedLst: (list) {
              return SmartRefresherApp(
                key: Key(req.normalFilterValue!.name),
                controller: con,
                list: list,
              );
            },
          );
        });
  }
}
