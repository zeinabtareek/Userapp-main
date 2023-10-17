



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/support_model.dart';

import '../../../../controller/base_controller.dart';
import '../../../../enum/view_state.dart';
import '../../../../helper/logger/logger.dart';
import '../../../../util/action_center/action_center.dart';
import '../../../../util/app_strings.dart';
import '../model/history_model.dart';
import '../repository/history_repo.dart';

class HistoryController extends BaseController    with SingleGetTickerProviderMixin{

  final HistoryRepo historyRepo=HistoryRepo();

  // HistoryController({required this.historyRepo});
  final ActionCenter _actionCenter = ActionCenter(Get.find<AbsLogger>());
  List<SupportData> model=<SupportData>[];
  // List<HistoryData> model=<HistoryData>[];
  late TabController tabController;
  bool _showCustomDate = false;
  bool get showCustomDate => _showCustomDate;
  String _filterStartDate = '';
  String get filterStartDate => _filterStartDate;

  String _filterEndDate = '';
  String get filterEndDate => _filterEndDate;
  final List<String> _filterList = ['all', 'today', 'yesterday', 'custom'];
  List<String> get filterList => _filterList;

  onTabChanged (index){
      if (index == 0) {
        getAllHistory(status:Strings.finished);
      } else if (index == 1) {
        getAllHistory(status:Strings.cancel);
        update();
      }    }
  @override
  void onInit() {
    super.onInit();
    getAllHistory(status: Strings.finished);

    tabController = TabController(length: 2, vsync: this);

  }
  void updateShowCustomDateState(bool state) {
    _showCustomDate = state;
    update();
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