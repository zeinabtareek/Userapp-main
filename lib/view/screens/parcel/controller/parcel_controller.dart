import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/categoty_model.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/create_parcel_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/repository/parcel_repo.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/screens/status_package_screen.dart';

import '../../../../enum/view_state.dart';
import '../../../../helper/display_helper.dart';
import '../../../../helper/location_permission.dart';
import '../../../../mxins/map/map_view_helper.dart';
import '../../../../pagination/typedef/page_typedef.dart';
import '../../../../util/action_center/exceptions.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../choose_from_map/choose_from_map_screen.dart';
import '../../history/model/history_model.dart' as history;
import '../../map/map_screen.dart';
import '../../ride/controller/ride_controller.dart';
import '../../where_to_go/controller/where_to_go_controller.dart';
import '../../where_to_go/model/order_create.dart';
import '../../where_to_go/repository/search_service.dart';
import '../model/create_parcel_body.dart';
import '../model/create_parcel_response.dart';
import '../page-use-case/model/req/get_parcel_list_package_req_model.dart';
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

class ParcelController extends BaseController
    with GetSingleTickerProviderStateMixin, MapViewHelper, MapHelper {
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

    senderContactController = TextEditingController();
    senderNameController = TextEditingController();
    senderAddressController = TextEditingController();
    searchOrderController = TextEditingController();
    receiverContactController = TextEditingController();
    receiverNameController = TextEditingController();
    receiverAddressController = TextEditingController();

    parcelDimensionController = TextEditingController();
    parcelWeightController = TextEditingController();
    parcelTypeController = TextEditingController();

    senderContactNode = FocusNode();
    senderNameNode = FocusNode();
    senderAddressNode = FocusNode();

    receiverContactNode = FocusNode();
    receiverNameNode = FocusNode();
    receiverAddressNode = FocusNode();

    parcelDimensionNode = FocusNode();
    parcelWeightNode = FocusNode();

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

  TextEditingController searchOrderController = TextEditingController();
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

  @override
  void onClose() {
    for (var element in [
      senderContactController,
      senderNameController,
      senderAddressController,
      receiverAddressController,
      receiverContactController,
      receiverNameController,
      parcelDimensionController,
      parcelWeightController,
      parcelTypeController,
      senderContactNode,
      senderNameNode,
      senderAddressNode,
      receiverContactNode,
      receiverNameNode,
      receiverAddressNode,
      parcelDimensionNode,
      parcelWeightNode,
      searchOrderController,
    ]) {
      element.dispose();
    }
    super.onClose();
  }

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
      return [source!, destination!];
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
      updateParcelState(ParcelDeliveryState.parcelInfoDetails);

      ///Zeinab uncomment this
      // await  createParcel([source!,destination!] );
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

  CreateParcelModel createParcelModel = CreateParcelModel();

  String? get packageId => Get.find<RideController>().selectedPackage.value?.id;
  String? get parcelCategoryId =>
      Get.find<RideController>().selectedSubPackage.value?.id;
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

  Future<List<ExtraRoutes>> googleRoutes(
    LatLng source,
    LatLng destination,
  ) async {
    List<ExtraRoutes> list = [];

    // if (extraPoint.isEmpty) {
    var resList = await FlutterPolylinePointsHelper.getRouteBetweenCoordinates(
        AppConstants.mapKey,
        source.latitude,
        source.longitude,
        destination.latitude,
        destination.longitude);

    for (var element in resList.points) {
      list.add(
        ExtraRoutes(
            lat: element.latitude.toString(),
            lng: element.longitude.toString(),
            location: ""
            //  await getPlaceNameFromLatLng(element.toLatLng),
            ),
      );
    }

    return list;
    // }
  }

  createParcel(List<LatLng> points) async {
    print('parcelCategoryId$parcelCategoryId');
    // await  parcelRepo.createAParcel(createParcelBody: null);
    LatLng source = points.first;
    LatLng destination = points.last;

    ///change this
    String time = "12";
    List<ExtraRoutes> gogleR = await googleRoutes(
      source,
      destination,
    );

    try {
      // var result = await actionCenter.execute(() async {
      //   setState(ViewState.busy);
      // isLoadingCreateATrip(true);

      createParcelModel = await parcelRepo.createAParcel(
        createParcelBody: CreateParcelBody(
          orderType: 'parcel',
          packageId: '9571cdde-45fc-4501-9538-82ac88c5b397',
          // packageId: packageId,
          // from: await _form(source),
          from: await _form(source),
          to: await _to(destination),
          senderNumber: senderContactController.text,
          senderName: senderNameController.text,
          receiverName: receiverContactController.text,
          receiverNumber: receiverNameController.text,
          parcelDimension: '12*12*9',
          parcelWeight: '33',
          whoPay: payReceiver ? 'receiver' : "sender",
          // parcelCategoryId: 'c4e3684c-b8a5-46bf-9a0e-6df25d457da4',
          parcelCategoryId: parcelCategoryId,
          time: time,
          distance: 33,
          note: '',
          paymentType: 'cash',
          googleRoutes: gogleR,
        ),
      );
      print('new trip data ${createParcelModel.data?.id}');

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

  toggleClipped(history.HistoryData item) {
    if (item.isClipped == true) {
      clipOff(item);
    } else {
      clipOn(item);
    }
  }

  clipOn(history.HistoryData item) {
    item.isClipped = true;
  }

  clipOff(history.HistoryData item) {
    item.isClipped = false;
  }

  clipAllOff(List<history.HistoryData> items) {
    for (var element in items) {
      element.isClipped = true;
    }
  }

  history.HistoryData? openItem;
  onClickCard(history.HistoryData item) {
    var con = Get.find<PaginateParcelListPackageController>();
    if (openItem != null) {
      if (openItem!.isClipped = false) {
        clipOn(openItem!);
        con.update([openItem!.id!]);
      }
    }
    toggleClipped(item);
    if (!item.isClipped) {
      openItem = item;
    } else {
      openItem = null;
    }
    con.update([item.id!]);
    var list = con.items.where((element) => element != item).toList();
    clipAllOff(list);
    update();
  }

  ParcelStateValue initHTap = ParcelStateValue.all;

  Rx<GetParcelListPackageReqModel> getParcelListPackageReqModel =
      GetParcelListPackageReqModel(1, normalFilterValue: ParcelStateValue.all)
          .obs;

  reSetFilter() {
    getParcelListPackageReqModel =
        GetParcelListPackageReqModel(1, normalFilterValue: ParcelStateValue.all)
            .obs;
    initHTap = ParcelStateValue.all;
    update();
  }

  onClickHTap(ParcelStateValue tab) {
    initHTap = tab;
    _filterTap(tab);
    update();
    // ignore: avoid_single_cascade_in_expression_statements
    Get.find<PaginateParcelListPackageController>()..onRefreshData();

    //................................................................
  }

  _filterTap(ParcelStateValue tab) {
    initHTap = tab;
    if (tab == ParcelStateValue.all) {
      getParcelListPackageReqModel.value =
          getParcelListPackageReqModel.value.clearFilterState();
    } else {
      getParcelListPackageReqModel.value =
          getParcelListPackageReqModel.value.addFilterState(tab);
    }
    update();
  }

  Timer? _debounce;

  debounceFunction(Function() action) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      action();
    });
  }

  filterSearch(String txt) {
    if (txt.isNotEmpty) {
      getParcelListPackageReqModel.value =
          getParcelListPackageReqModel.value.addOrderId(txt);
    } else {
      getParcelListPackageReqModel.value =
          getParcelListPackageReqModel.value.clearOrderId();
      initHTap = ParcelStateValue.all;
      _filterTap(ParcelStateValue.all);
      update();
    }

    debounceFunction(() {
      // ignore: avoid_single_cascade_in_expression_statements
      Get.find<PaginateParcelListPackageController>()..restData;
      Get.find<PaginateParcelListPackageController>().onRefreshData();
    });
  }

  List<LatLng> pickedPoints = [
    const LatLng(37.421998189179185, -122.08399951457977),
    const LatLng(37.41511878640148, -122.0886980742216),
  ];
  Future<void> drawMarkersIfHavePickedPoints() async {
    if (pickedPoints.isNotEmpty) {
      List<Marker> markers = [];
      for (var element in pickedPoints) {
        markers.add(Marker(
          markerId: MarkerId(pickedPoints.indexOf(element).toString()),
          position: element,
          // ripple: false,
          icon: BitmapDescriptor.fromBytes(
              await getBytesFromAsset(Images.locationFill, 50)),
          onTap: () {},
        ));
      }

      addListMarker(update, markers: markers);
    }
  }

  Future drawPolylineIfHavePickedPoints() async {
    for (var i = 0; i < pickedPoints.length - 1; i++) {
      // if (i + 1 < pickedPoints.length) {
      LatLng fPoint = pickedPoints[i];
      LatLng lPoint = pickedPoints[i + 1];
      var x = await FlutterPolylinePointsHelper.getRouteBetweenCoordinates(
        AppConstants.mapKey,
        fPoint.latitude,
        fPoint.longitude,
        lPoint.latitude,
        lPoint.longitude,
      );

      Polyline polyline = Polyline(
        polylineId: PolylineId("$i"),
        points: x.points.map((e) => e.toLatLng).toList(),
        color: generateRandomColor(),
        width: 5,
        // patterns: [PatternItem.dash(3.0)],
      );
      addOnePolyline(update, polyline: polyline);
    }
  }
  // }

  Color generateRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256), // Red value (0-255)
      random.nextInt(256), // Green value (0-255)
      random.nextInt(256), // Blue value (0-255)
      1.0, // Alpha (transparency) value (0.0-1.0)
    );
  }

  RxBool isLoadingShowOrderById = false.obs;
  showOrderById(history.HistoryData item) async {
    var con = Get.find<PaginateParcelListPackageController>();
    try {
      var result = await actionCenter.execute(() async {
        setState(ViewState.busy);
        isLoadingShowOrderById(true);
        var res = await parcelRepo.showOrderById(item.id!);
        // res.from!.location = "Order";

        var l = con.items.firstWhere((element) => element == item);
        item = res.copyWith(
          from: res.from!.copyWith(location: "Order"),
        );

        l = item;
        con.update();
        update();
        setState(ViewState.idle);
        isLoadingShowOrderById(false);
        // Get.find<PaginateParcelListPackageController>().update();
      }, checkConnection: true);

      if (!result) {
        setState(ViewState.error);
        if (kDebugMode) {
          print(" ::: error");
        }
        isLoadingShowOrderById(false);
      }
    } on CustomException catch (e) {
      OverlayHelper.showErrorToast(Get.overlayContext!, e.message);
    }
  }
}
