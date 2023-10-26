import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';

import '../../../../helper/logger/logger.dart';
import '../../../../pagination/typedef/page_typedef.dart';
import '../../../../util/action_center/action_center.dart';
import '../model/support_model.dart';
import '../page-use-case/model/req/get_trip_req_model.dart';
import '../repository/history_repo.dart';

class HistoryController extends BaseController
    with SingleGetTickerProviderMixin {
  final HistoryRepo historyRepo = HistoryRepo();

  // HistoryController({required this.historyRepo});
  final ActionCenter _actionCenter = ActionCenter(Get.find<AbsLogger>());
  List<SupportData> model = <SupportData>[];
  // List<HistoryData> model=<HistoryData>[];
  late TabController tabController;
  bool _showCustomDate = false;
  bool get showCustomDate => _showCustomDate;
  final String _filterStartDate = '';
  String get filterStartDate => _filterStartDate;

  final String _filterEndDate = '';
  String get filterEndDate => _filterEndDate;
  final List<String> _filterList = ['all', 'today', 'yesterday', 'custom'];
  List<String> get filterList => _filterList;

  RxInt indexView = 0.obs;

  Rxn<List<DateTime>> selectedDate = Rxn();

  RxBool get isCompleteView => (indexView.value == 0).obs;

  RxBool get isCancelView => (indexView.value == 1).obs;

  Rx<GetTripReqModel> cancelReq = GetTripReqModel(
    1,
    normalFilterValue: StateValue.cancel,
  ).obs;

  Rx<GetTripReqModel> completeReq = GetTripReqModel(
    1,
    normalFilterValue: StateValue.finished,
  ).obs;
  onTabChanged(index) {
    indexView(index);
  }

  @override
  void onInit() {
    super.onInit();
    // getAllHistory(status: Strings.finished);

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void updateShowCustomDateState(bool state) {
    _showCustomDate = state;
    update();
  }

  RxBool isDataFilterOn = false.obs;
  addDataFilter(List<DateTime> dates) {
    _returnActiveReq().addStartEndDate(dates.first, dates.last);
    isDataFilterOn(true);
    Get.find<PaginateTripHistoryController>().onRefreshData();
  }

  clearDatesFilter() {
    _returnActiveReq().clearDatesFilter();
    isDataFilterOn(false);
    Get.find<PaginateTripHistoryController>().onRefreshData();
  }

  GetTripReqModel _returnActiveReq() {
    if (isCompleteView.isTrue) {
      return completeReq.value;
    } else {
      return cancelReq.value;
    }
  }

  //TODO get All History
  // final  model=HistoryModel();
  getAllHistory({status}) async {
    // var result = (await _actionCenter.execute(
    //       () async {
    //
    //     setState(ViewState.busy);
    model = await historyRepo.getAllHistory(status: status);
    //     if (model.isNotEmpty ) {
    //        setState(ViewState.idle);
    //     } else {
    //       setState(ViewState.noDate);
    //     }   },
    //   checkConnection: true,
    // ));
    // if (!result) {
    //   setState(ViewState.error);
    //   print(" ::: error in getting history ");
    print(" :::$model");
    // }update();
  }
}
