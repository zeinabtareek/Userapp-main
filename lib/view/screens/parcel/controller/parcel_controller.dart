import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/categoty_model.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/repository/parcel_repo.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/status_package_screen.dart';

import '../../../../util/app_strings.dart';
import '../../map/map_screen.dart';
import '../rate/check_rates_screen.dart';

enum ParcelDeliveryState {
  initial,
  parcelInfoDetails,
  addOtherParcelDetails,
  riseFare,
  findingRider,
  suggestVehicle,
  acceptRider,
  otpSent,
  parcelOngoing,
  parcelComplete
}

class ParcelController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements GetxService {
  final ParcelRepo parcelRepo;
  final isBtnTapped=false.obs;
  final isSelected=1.obs;
  ParcelController({required this.parcelRepo});

  var currentParcelState = ParcelDeliveryState.initial;
  late TabController tabController;
  int counter=1;
  @override
  void onInit() async {
    super.onInit();
    currentParcelState ==
        ParcelDeliveryState.initial;
    tabController = TabController(length: 2, vsync: this);
    parcelTypeController.text =
        parcelCategoryList[selectedParcelCategory].categoryTitle.toString().tr;

    senderAddressController.text = "52 Bedok Reservoir Cres Singapore 479226";
    receiverAddressController.text =
        "Bidadari Park Drive Singapore - 1 Wallich St Singapore";
  }

  List optionsList = [
 {'image': Images.statusIcon,  'title': Strings.pickUp.tr,'onTap':    MapScreen(fromScreen: Strings.parcel,)},
 {'image': Images.deliveryTruck, 'title': Strings.statusOrder.tr,'onTap':  const StatusPackageScreen() }
  ];


  List<Widget> navigationOptions=[
 const CheckRatesScreen(),
   MapScreen(fromScreen: 'ride'),
  ]
;  List<CategoryModel> parcelCategoryList = [
    CategoryModel(
      categoryImage: Images.parcelGift,
      categoryTitle: "gift",
    ),
    CategoryModel(
        categoryImage: Images.parcelFragile, categoryTitle: "fragile"),
    CategoryModel(
        categoryImage: Images.parcelDocument, categoryTitle: "document"),
    CategoryModel(categoryImage: Images.parcelBox, categoryTitle: "parcel_box"),
  ];

  bool parcelDetailsAvailable = false;
  int selectedParcelCategory = 0;
  int selectedSenderAddressIndex = -1;
  int selectedReceiverAddressIndex = -1;
  bool payReceiver = true;

  TextEditingController senderContactController = TextEditingController();
  TextEditingController senderNameController = TextEditingController();
  TextEditingController senderAddressController = TextEditingController();

  TextEditingController receiverContactController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController receiverAddressController = TextEditingController();

  TextEditingController parcelDimensionController = TextEditingController();
  TextEditingController parcelWeightController = TextEditingController();
  TextEditingController parcelTypeController = TextEditingController();

  FocusNode senderContactNode = FocusNode();
  FocusNode senderNameNode = FocusNode();
  FocusNode senderAddressNode = FocusNode();

  FocusNode receiverContactNode = FocusNode();
  FocusNode receiverNameNode = FocusNode();
  FocusNode receiverAddressNode = FocusNode();

  FocusNode parcelDimensionNode = FocusNode();
  FocusNode parcelWeightNode = FocusNode();

  void updateParcelCategoryIndex(int newIndex) {
    selectedParcelCategory = newIndex;
    parcelTypeController.text =
        parcelCategoryList[selectedParcelCategory].categoryTitle.toString().tr;
    update();
  }

  void updateTabControllerIndex(int newIndex) {
    tabController.index = newIndex;
    update();
  }

  void setParcelAddress(String address) {
    if (tabController.index == 0) {
      senderAddressController.text = address;
    } else {
      receiverAddressController.text = address;
    }
    update();
  }

  void updateParcelDetailsStatus() {
    if (parcelWeightController.text.isNotEmpty &&
        parcelDimensionController.text.isNotEmpty) {
      parcelDetailsAvailable = true;
    } else {
      parcelDetailsAvailable = false;
    }
    update();
  }

  void updateParcelState(ParcelDeliveryState newState) {
    currentParcelState = newState;
    update();
  }

  void updatePaymentPerson(bool newValue) {
    payReceiver = newValue;
    update();
  }

  List kilosList=['1kg','1kg','1kg','1kg','1kg','1kg',];
  add(){
    counter++;
    update();
  }  minimize(){
    counter>1?
    counter--:counter=1;
    update();
  }

  void isTapped(int index) {
    isSelected.value = index;
    update();
  }
}
