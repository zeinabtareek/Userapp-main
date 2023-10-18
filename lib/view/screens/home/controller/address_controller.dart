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
  final AddressRepo? addressRepo;

  AddressController({this.addressRepo});

  List<AddressData> addressList = [];

  AddressRepo addressRepo1 = AddressRepo();

  int? _currentIndex = 0;

  int? get currentIndex => _currentIndex;


  AddressModel addressModel = AddressModel();
  AddressModel suggestionAddressModel = AddressModel();

  @override
  onInit() async {
    super.onInit();

    await getAddressList();
    await getSuggestedAddressList();
  }

  Future<void> getAddressList() async {
    setState(ViewState.busy);

    try {
      addressModel = await addressRepo1.getAddressList();

      print('addressList ${addressModel.data?.length}');
      // }
    } on MsgModel catch (e) {
      // TODO
    }
    setState(ViewState.idle);

    update();
  }

  Future<void> getSuggestedAddressList() async {
    setState(ViewState.busy);

    try {
      suggestionAddressModel = await addressRepo1.getSuggestedAddressList();

      print('suggestionAddressModel ${suggestionAddressModel.data?.length}');
      // }
    } on MsgModel catch (e) {
      // TODO
    }
    setState(ViewState.idle);

    update();
  }





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