import 'dart:ffi';

import 'package:get/get.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/main_use_case/get_address_use_case.dart';

import '../../../../authenticate/data/models/base_model.dart';
import '../../../../enum/view_state.dart';
import '../../../../main_use_case/get_packages_details_use_case.dart';
import '../../parcel/delivery_staus_screen.dart';
import '../../parcel/delivery_staus_screen.dart';
import '../../parcel/delivery_staus_screen.dart';
import '../../ride/model/address_model.dart';
import '../repository/address_repo.dart';

class AddressController extends BaseController implements GetxService {
  final AddressRepo ?addressRepo;

  AddressController({  this.addressRepo});
   List<AddressData> addressList = [];

  int? _currentIndex = 0;

  int? get currentIndex => _currentIndex;

  // Future<void> getAddressList() async {
  //   var response = await GetAddressUseCase().call();
  //
  //   if (response.status == 200) {
  //     addressList = [];
  //
  //     if (response.data != null) {
  //       for (var element in response.data!) {
  //         addressList.add(AddressModel.fromJson(element.toJson()));
  //       }
  //     }
  //
  //     update();
  //   } else {
  //     // Handle the error case
  //     // ApiChecker.checkApi(response);
  //   }
  // }
  //
@override
  onInit()async{
  super.onInit();

  getAddressList();
}
  Future<void> getAddressList() async {


    try {
      var lis = await addressRepo?.getAddressList();

      print('addressList ${lis }');
      // for (var element in lis) {
      //   var json = element.toJson(); // Convert AddressModel to a Map<String, dynamic>
      //   addressList.add(AddressData.fromJson(json));
      //   print('addressList ${addressList.first.name}');
      // }
    } on MsgModel catch (e) {
      // TODO
    }
    update();
  }


  AddressData model =AddressData();
  // getAllSetting() async {
  //   // var result = (await _actionCenter.execute(
  //   //       () async {
  //
  //       setState(ViewState.busy);
  //       model = await addressRepo.getAddressList();
  //       if (model.data != null ) {
  //         setState(ViewState.idle);
  //       }
  //     },
  //     checkConnection: true,
  //   ));
  //   if (!result) {
  //     setState(ViewState.error);
  //     print(" ::: error");
  //   }
  //
  //   print(" ::: $model");
  // }
  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }
}
