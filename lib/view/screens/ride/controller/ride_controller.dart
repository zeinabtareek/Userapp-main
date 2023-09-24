import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/ride/repository/ride_repo.dart';

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
  var selectedCategory = RideType.car;
  var selectedSubCategory = RideType.car;

  bool isBiddingOn = true;

  double currentFarePrice = 0;

  int rideCategoryIndex = 0;
  int rideSubCategoryIndex = 0;

  TextEditingController inputFarePriceController = TextEditingController();

  TextEditingController senderContactController = TextEditingController();

  FocusNode parcelWeightNode = FocusNode();
     double heightOfTypes=0.0;  bool isExpanded = false;
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

  void vehicleToggle(RideType newType){
    isExpanded = !isExpanded;
    heightOfTypes = isExpanded ? 110.0 : 0.0;
    rideSubCategoryIndex = 0;

    update();
  }

  void updateRideCurrentState(RideState newState) {
    currentRideState = newState;
    update();
  }

  void updateSelectedRideType(RideType newType) {
    selectedCategory = newType;
    update();
  }  void updateSelectedSubRideType(RideType newType) {
    selectedSubCategory = newType;
    update();
  }

  void setRideCategoryIndex(int newIndex) {
    rideCategoryIndex = newIndex;
    update();
  }  void setSubRideCategoryIndex(int newIndex) {
    rideSubCategoryIndex = newIndex;
    update();
  }

  void resetControllerValue() {
    currentRideState = RideState.initial;
    selectedCategory = RideType.car;
    selectedSubCategory = RideType.car;
    rideCategoryIndex = 0;
    rideSubCategoryIndex = 0;
    isExpanded=false;
     heightOfTypes=0;
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
}
