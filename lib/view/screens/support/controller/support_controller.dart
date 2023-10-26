


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/view/screens/support/repository/help_and_support_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../enum/view_state.dart';
import '../../../../helper/logger/logger.dart';
import '../../../../util/action_center/action_center.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../history/model/support_model.dart';
import '../model/help_model.dart';

class SupportController extends BaseController {
  final HelpAndSupportRepo helpAndSupportRepo=HelpAndSupportRepo();



  final List<String> complainsList = ['Good Driver', 'Bad Driver', 'Good Driver', 'Good Driver'];
    String ?initialSelectItem;
  final feedBackController=TextEditingController();
  final ActionCenter _actionCenter = ActionCenter(Get.find<AbsLogger>());
  int _helpAndSupportIndex = 0;
  int get helpAndSupportIndex => _helpAndSupportIndex;
  @override
    onInit() async {
    // TODO: implement onInit
    super.onInit();

   await   getAllSetting();



    // initialSelectItem = complainsList.first;
  }
  ///TODO get All Setting
  SupportModel model=SupportModel();
  // HelpAndSupportModel model=HelpAndSupportModel();
  getAllSetting() async {
    var result = (await _actionCenter.execute(
          () async {

        setState(ViewState.busy);
        model = await helpAndSupportRepo.getAllSettings();
        if (model.data != null ) {
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
    if (!await launchUrl(Uri.parse( url))) {
      throw 'Could not launch $url';
    }
  }
  void setHelpAndSupportIndex(int index){
    _helpAndSupportIndex = index;
    update();
  }

 submitComplain()async{
    if( initialSelectItem == null){
      OverlayHelper.showErrorToast(Get.overlayContext!, 'select_complain_type'.tr);
    }else
    if(feedBackController.text.isEmpty ){
      OverlayHelper.showErrorToast(Get.overlayContext!, 'write_complain'.tr);
    }
   else{
      setState(ViewState.busy);
      await helpAndSupportRepo.submitComplain(
        message: feedBackController.text,
        type:initialSelectItem,
      );
      setState(ViewState.idle);

    }
  }
}