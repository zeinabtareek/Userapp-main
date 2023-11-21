import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/categoty_model.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/create_parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/repository/parcel_repo.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/screens/status_package_screen.dart';

import '../../../../helper/display_helper.dart';
import '../../../../helper/location_permission.dart';
import '../../../../util/action_center/exceptions.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../choose_from_map/choose_from_map_screen.dart';
import '../../map/map_screen.dart';
import '../../ride/controller/ride_controller.dart';
import '../../where_to_go/controller/where_to_go_controller.dart';
import '../../where_to_go/model/order_create.dart';
import '../../where_to_go/repository/search_service.dart';
import '../model/create_parcel_body.dart';
import '../model/create_parcel_response.dart';
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

class ParcelController
    extends GetxController

    with GetSingleTickerProviderStateMixin
    // implements GetxService
{
  final ParcelRepo parcelRepo;
  final isBtnTapped = false.obs;
  final isSelected = 1.obs;

  ParcelController({required this.parcelRepo});

  var currentParcelState = ParcelDeliveryState.initial;
  late TabController tabController;
  int counter = 1;

  @override
  void onInit() async {
    super.onInit();
    currentParcelState == ParcelDeliveryState.initial;
    tabController = TabController(length: 2, vsync: this);
    parcelTypeController.text =
        parcelCategoryList[selectedParcelCategory].categoryTitle.toString().tr;

    senderAddressController.text = "52 Bedok Reservoir Cres Singapore 479226";
    receiverAddressController.text =
        "Bidadari Park Drive Singapore - 1 Wallich St Singapore";
  }

  List optionsList = [
    {
      'image': Images.statusIcon,
      'title': Strings.pickUp.tr,
      'onTap': MapScreen(
        fromScreen: Strings.parcel,
      )
    },
    {
      'image': Images.deliveryTruck,
      'title': Strings.statusOrder.tr,
      'onTap': const StatusPackageScreen()
    }
  ];

  List<Widget> navigationOptions = [
    const CheckRatesScreen(),
    MapScreen(fromScreen: 'ride'),
  ];

  List<CategoryModel> parcelCategoryList = [
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

  List kilosList = [
    '1kg',
    '1kg',
    '1kg',
    '1kg',
    '1kg',
    '1kg',
  ];

  add() {
    counter++;
    update();
  }

  minimize() {
    counter > 1 ? counter-- : counter = 1;
    update();
  }

  void isTapped(int index) {
    isSelected.value = index;
    update();
  }

  LatLng? source;
  LatLng? destination;
  List<LatLng>? get _getPoints {
      if (source == null || destination == null) {
      return null;
    } else {
      return [source!,   destination!];
    }
  }
  checkDataEmpty() async {
    if (senderContactController.text.isEmpty) {
      showCustomSnackBar('enter_sender_contact_number'.tr);
    } else if (senderNameController.text.isEmpty) {
      showCustomSnackBar('enter_sender_name'.tr);
    } else if (senderNameController.text.isEmpty) {
      showCustomSnackBar('enter_sender_address'.tr);
    } else if (receiverContactController.text.isEmpty) {
      showCustomSnackBar('enter_receiver_contact_number'.tr);
    } else if (receiverNameController.text.isEmpty) {
      showCustomSnackBar('enter_receiver_name'.tr);
    } else if (receiverNameController.text.isEmpty) {
      showCustomSnackBar('enter_receiver_address'.tr);
    } else {
      // updateParcelState(ParcelDeliveryState.parcelInfoDetails);
print("source$source");
print("destination $destination");

      await  createParcel([source!,destination!] );
      // await Get.find<CreateParcelController>().createParcel([source!,destination!]);
    }
  }
///CREATE A PARCEL

  final searchServices = SearchServices();
  checkPermissionBeforeNavigation(PointType pointType, context,
      {int? index}) async {
    await checkPermissionBeforeNavigate(context, () async {
      await goToScreenAndRecodeSelect(pointType, index: index);
    });
  }
  @override
  Future<String> getPlaceNameFromLatLng(LatLng latlng) async {
    return searchServices.getPlaceNameFromLatLng(latlng);
  }

  addFromPoint(LatLng point) {
    source = point;
  }

  addToPoint(LatLng point) {
    destination = point;
  }

  Future<void> goToScreenAndRecodeSelect(PointType pointType,
      {int? index}) async {

    Get.to(() => ChooseFromMapScreen(_getPoints))!.then((point) async {
      if (point != null) {
        if (pointType == PointType.from) {
          senderAddressController.text = await getPlaceNameFromLatLng(point);
           addFromPoint(point);
           print('point11 $point');
        } else if (pointType == PointType.to) {
          receiverAddressController.text = await getPlaceNameFromLatLng(point);
          addToPoint(point);
        }
        update(["SenderReceiver"]);
      }
    });
  }




  CreateParcelModel createParcelModel=CreateParcelModel();

  String? get packageId => Get.find<RideController>().selectedPackage.value?.id;

  Future<From> _form(LatLng source) async {
    return From(
        lat: source.latitude.toString(),
        lng: source.longitude.toString(),
        location: await getPlaceNameFromLatLng(source));
  }

  Future<To> _to(LatLng destination) async {
    return To(
      lat: destination.latitude.toString(),
      lng: destination.longitude.toString(),
      location: await getPlaceNameFromLatLng(destination),
    );
  }
  createParcel( List<LatLng> points )async{
    // await  parcelRepo.createAParcel(createParcelBody: null);
    LatLng source = points.first; // Example source coordinate (San Francisco)
    LatLng destination = points.last;
    ///change this
    String time = "12";
    try {
      // var result = await actionCenter.execute(() async {
      //   setState(ViewState.busy);
      // isLoadingCreateATrip(true);

      createParcelModel = await parcelRepo.createAParcel(
        createParcelBody: CreateParcelBody(
          orderType: 'parcel',
          packageId: packageId,
          // from: await _form(source),
          from: await _form(source),
          to: await _to(destination),


          time: time,
          distance: 33,
          note: '',

          paymentType: 'cash',
          googleRoutes: [],
        ),
      );
      print('new trip data   ${createParcelModel.data?.id}');


     // setState(ViewState.idle);
      //  isLoadingCreateATrip(false);
      // }, checkConnection: true);
      //
      // if (!result) {
      //   setState(ViewState.error);
      //   print(" ::: error");
      // isLoadingCreateATrip(false);
      // }

      return createParcelModel; // Return the acceptedOrderData object
    } on CustomException catch (e) {
      OverlayHelper.showErrorToast(Get.overlayContext!, e.message);
    }

    throw Exception(
        "Unexpected error occurred"); // Throw an exception if none of the catch blocks are executed
  }

}
