import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';
import 'package:ride_sharing_user_app/view/screens/ride/repository/ride_repo.dart';

import '../../../../util/app_strings.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../home/model/categoty_model.dart';
import '../../where_to_go/controller/create_trip_controller.dart';
import '../../where_to_go/controller/where_to_go_controller.dart';
import '../model/order_price_model.dart';

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

class RideController extends BaseController implements GetxService {
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
  TextEditingController noteController = TextEditingController();

  TextEditingController senderContactController = TextEditingController();

  FocusNode parcelWeightNode = FocusNode();
  double heightOfTypes = 0.0;
  bool isExpanded = false;
  dynamic distance = 0.0;

  @override
  onInit() async {
    super.onInit();
    // await getPrice();
     inputFarePriceController.text = "0.00";
    // distance=await  Get.find<WhereToGoController>().calculateDistance();
  }

  @override
    dispose() {
    // TODO: implement dispose
    super.dispose();
    promoCodeController.clear();
  }

  @override
  void onClose() {
    super.onClose();
    heightOfTypes = 0.0;
    isExpanded = false;
  }
  // var distance ;
  Future<double?> calculateDistance() async {
    distance=  await Get.find<CreateATripController>().calculateDistance(
      LatLng(33.7749, -122.4194), // San Francisco
      LatLng(
          37.7753, -122.4199), // Replace with your actual point 1 coordinates
    );
    return distance;
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
    print('selectedCategoryTypeEnum :$selectedCategoryTypeEnum');
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

  // calculateDistance()async{
  //
  //
  //   await  Get.find<CreateATripController>().calculateDistance(
  //       LatLng(37.7749, -122.4194), // San Francisco
  //       LatLng(37.7753, -122.4199) // Replace with your actual point 1 coordinates
  //
  //   );
  // }
  /// Set Rate For The Trip
  TextEditingController promoCodeController = TextEditingController();
  OrderPriceData priceData = OrderPriceData();
final loading=false.obs;
  getPromoCodeDiscount() async {
    loading.value = true;
    try {
      var result = await actionCenter.execute(() async {
        if (promoCodeController.text.isEmpty) {
          OverlayHelper.showErrorToast(
              Get.overlayContext!, Strings.noEnteredPromoCode.tr);
        } else {
          double? distance = await calculateDistance();
          priceData = await rideRepo.getPrice(
            packageId: selectedPackage.value!.id,
            vehicleTypeId: selectedSubPackage.value!.id,
            promoCode: promoCodeController.text,
              distance: 22
            // distance: distance,
          );
          OverlayHelper.showSuccessToast(Get.overlayContext!, Strings.done.tr);
          print('priceData $priceData');
        }
      }, checkConnection: true);

      if (!result) {
        setState(ViewState.error);
        print(" ::: error");
      }

      return priceData; // Return the acceptedOrderData object
    } catch (e) {
      print(e);
    } finally {
      loading.value = false; // Stop the loading indicator
  update(); // Trigger a rebuild of the GetBuilder widget

    }
   }


getOrderPrice()async{
  setState(ViewState.busy);
  priceData= await   rideRepo.getPrice(
                  packageId: selectedPackage.value!.id,
                  vehicleTypeId: selectedSubPackage.value!.id,
                  promoCode: promoCodeController.text,
                  distance: 22
                  // distance: distance

  );
  setState(ViewState.idle);

}
}
