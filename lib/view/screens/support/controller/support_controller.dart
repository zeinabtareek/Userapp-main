import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/view/screens/support/repository/help_and_support_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../enum/view_state.dart';
import '../../../../helper/logger/logger.dart';
import '../../../../util/action_center/action_center.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../history/model/support_model.dart';
import '../model/complain_res_model.dart';
import '../model/help_model.dart';

class SupportController extends BaseController
    with GetTickerProviderStateMixin {
  final HelpAndSupportRepo helpAndSupportRepo = HelpAndSupportRepo();

  RxList<ComplainResModel> complains = <ComplainResModel>[].obs;

  TabController? tabController;

  Rxn<ComplainResModel> initialSelectItem = Rxn();
  final feedBackController = TextEditingController();
  final ActionCenter _actionCenter = ActionCenter(Get.find<AbsLogger>());
  int _helpAndSupportIndex = 0;
  int get helpAndSupportIndex => _helpAndSupportIndex;
  @override
  onInit() async {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    await getComplains();
    await getAllSetting();

    // initialSelectItem = complainsList.first;
  }

  ///TODO get All Setting
  SupportModel model = SupportModel();
  // HelpAndSupportModel model=HelpAndSupportModel();
  getAllSetting() async {
    var result = (await _actionCenter.execute(
      () async {
        setState(ViewState.busy);
        model = await helpAndSupportRepo.getAllSettings();
        if (model.data != null) {
          setState(ViewState.idle);
        }
      },
      checkConnection: true,
    ));
    if (!result) {
      setState(ViewState.error);
      print(" ::: error");
    }

    print(" ::: $model");
  }

  Future<void> launchUrlFun(String url, bool isMail) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  void setHelpAndSupportIndex(int index) {
    _helpAndSupportIndex = index;
    tabController?.index = index;
    update();
  }

  RxBool isLoading = false.obs;
  submitComplain() async {
    if (initialSelectItem.value == null) {
      OverlayHelper.showErrorToast(
          Get.overlayContext!, 'select_complain_type'.tr);
    } else if (feedBackController.text.isEmpty) {
      OverlayHelper.showErrorToast(Get.overlayContext!, 'write_complain'.tr);
    } else {
      isLoading(true);
      await helpAndSupportRepo.submitComplain(
        message: feedBackController.text,
        complainTypeId: initialSelectItem.value!.id,
      );
      isLoading(false);
    }
  }

  getComplains() async {
    var result = (await _actionCenter.execute(
      () async {
        setState(ViewState.busy);
        complains.value = await helpAndSupportRepo.getComplainTypes();
        if (complains.isNotEmpty) {
          setState(ViewState.idle);
        }
      },
      checkConnection: true,
    ));
    if (!result) {
      setState(ViewState.error);
      print(" ::: error");
    }

    print(" ::: $model");
  }
}
