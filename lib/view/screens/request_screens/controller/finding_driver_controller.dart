


import 'package:get/get.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/view/screens/request_screens/controller/base_map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/controller/create_trip_controller.dart';

import '../../../../enum/request_states.dart';

class FindingDriverController extends GetxController{

  ///handle future state only for testing
  @override
  onInit()async{
    super.onInit();
   await handelState();

}
handelState()async{
  if( Get.find<BaseMapController>().widgetNumber.value ==request[RequestState.findDriverState]){
  // Get.find<BaseMapController>(). key.currentState?.contract();
    Future.delayed(const Duration(seconds: 5), () async {
      Get.find<BaseMapController>(). key.currentState!.expand();
      Get.find<BaseMapController>().changeState(request[RequestState.findDriverState]!);

      Get.find<BaseMapController>().update();

      Get.find<CreateATripController>().showTrip(orderId:'');

       // Get.find<BaseMapController>().changeState(request[RequestState.riderDetailsState]!);//riderDetailsState
    });
  }
  }

}