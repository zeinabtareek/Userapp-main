import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/ride/repository/ride_repo.dart';

import '../../home/model/categoty_model.dart';

enum RideState {
  initial,
  riseFare,
  findingRider,
  getPrice,
  acceptingRider,
  afterAcceptRider,
  otpSent,
  ongoingRide,
  completeRide
}

enum RideType { car, bike, parcel, luxury }

class RideController extends GetxController implements GetxService {
  final RideRepo rideRepo;

  RideController({required this.rideRepo});

  var currentRideState = RideState.initial;
  var selectedCategoryTypeEnum = RideType.car;

  Rxn<CategoryModel> selectedPackage = Rxn();
  Rxn<CategoryModel> selectedSubPackage = Rxn();

  var selectedSubCategory = RideType.car;

  bool isBiddingOn = true;

  double currentFarePrice = 0;

  int rideCategoryIndex = 0;
  int rideSubCategoryIndex = 0;

  TextEditingController inputFarePriceController = TextEditingController();

  TextEditingController senderContactController = TextEditingController();

  FocusNode parcelWeightNode = FocusNode();
  double heightOfTypes = 0.0;
  bool isExpanded = false;
  @override
  void onInit() {
    super.onInit();
    inputFarePriceController.text = "0.00";
  }

  @override
  void onClose() {
    super.onClose();
    heightOfTypes = 0.0;
    isExpanded = false;
  }

  void vehicleToggle() {
    isExpanded = !isExpanded;
    heightOfTypes = isExpanded ? 110.0 : 0.0;
    rideSubCategoryIndex = 0;

    update();
  }

  void updateRideCurrentState(RideState newState) {
    currentRideState = newState;
    update();
    // refresh();
  }

  void updateSelectedRideType(RideType newType) {
    selectedCategoryTypeEnum = newType;
    update();
  }

  void updateSelectedSubRideType(RideType newType) {
    selectedSubCategory = newType;
    update();
  }

  void setRideCategoryIndex(int newIndex) {
    rideCategoryIndex = newIndex;
    update();
  }

  void setSubRideCategoryIndex(int newIndex) {
    rideSubCategoryIndex = newIndex;
    update();
  }

  void resetControllerValue() {
    currentRideState = RideState.initial;
    selectedCategoryTypeEnum = RideType.car;
    selectedSubCategory = RideType.car;
    rideCategoryIndex = 0;
    rideSubCategoryIndex = 0;
    isExpanded = false;
    heightOfTypes = 0;
    update();
  }

  void updateFareValue({bool increment = true}) {
    if (increment) {
      currentFarePrice++;
    } else {
      if (currentFarePrice > 1) {
        currentFarePrice--;
      }
    }
    inputFarePriceController.text = currentFarePrice.toString();
    update();
  }

  /// Set Rate For The Trip



  // submitComplain()async{
  //   if( initialSelectItem == null){
  //     OverlayHelper.showErrorToast(Get.overlayContext!, 'select_complain_type'.tr);
  //   }else
  //   if(feedBackController.text.isEmpty ){
  //     OverlayHelper.showErrorToast(Get.overlayContext!, 'write_complain'.tr);
  //   }
  //   else{
  //     setState(ViewState.busy);
  //     await helpAndSupportRepo.submitComplain(
  //       message: feedBackController.text,
  //       type:initialSelectItem,
  //     );
  //     setState(ViewState.idle);
  //
  //   }
  // }



}
