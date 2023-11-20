import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../bases/base_controller.dart';
import '../../../../enum/view_state.dart';
import '../../../../helper/location_permission.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../choose_from_map/choose_from_map_screen.dart';
import '../../request_screens/controller/base_map_controller.dart';
import '../../request_screens/screens/base_map/base_map_screen.dart';
import '../../ride/controller/ride_controller.dart';
import '../../ride/model/address_model.dart';
import '../../ride/repository/ride_repo.dart';
import '../model/search_suggestion_model.dart';
import '../model/suggested_route_model.dart';
import '../repository/search_service.dart';

enum PointType {
  from,
  to,
  extra,
}

class WhereToGoController extends BaseController implements GetxService {
  // final SetMapRepo setMapRepo;

  WhereToGoController();
  // WhereToGoController({required this.setMapRepo});

  List<SuggestedRouteModel> suggestedRouteList = [];
  bool addEntrance = false;
  final fromRouteController = TextEditingController();
  final toRouteController = TextEditingController();

  final entranceController = TextEditingController();
  final entranceNode = FocusNode();
  final fromNode = FocusNode();
  final toRoutNode = FocusNode();

  final searchController = TextEditingController().obs;
  final selectedSuggestedAddress = ''.obs;
  List listOfSuggestedPlaces = [
    'place one',
    'place two',
    'place three',
    'place four',
  ];

  ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();

    for (var element in [
      fromRouteController,
      fromNode,
      toRouteController,
      toRoutNode,
      ...extraTextEditingControllers,
      ...extraFocusNodes,
    ]) {
      element.dispose();
    }
  }

  bool loadedSaved = false;
  bool loadedSuggest = false;
  // List<String> extraRoutes = [];

  List<LatLng> extraPoints = [];

  LatLng get defLangLng => const LatLng(0, 0);

  // List<LatLng> selectedPoints = [];
  LatLng? source;
  LatLng? destination;

  List<TextEditingController> extraTextEditingControllers = [];

  List<FocusNode> extraFocusNodes = [];
  int get currentExtraRouteLength => extraTextEditingControllers.length;

  bool get isExtraPointsIsLengthIsOne => extraFocusNodes.length == 1;

  void addExtraRoute() {
    extraTextEditingControllers.add(TextEditingController());
    extraFocusNodes.add(FocusNode());
    extraPoints.add(defLangLng);
    update(["WhereToGoController"]);
  }

  void removeExtraRoute({int? index}) {
    if (index != null) {
      extraTextEditingControllers.removeAt(index);
      extraFocusNodes.removeAt(index);
    } else {
      extraTextEditingControllers.removeLast();
      extraFocusNodes.removeLast();
    }
    update(["WhereToGoController"]);
  }

  void setAddEntrance() {
    addEntrance = !addEntrance;
    update(["WhereToGoController"]);
  }

//   Future<double?> calculateDuration() async {
//     duration = await Get.find<CreateATripController>().calculateDuration(
//       selectedPoints.first,
// // TODO:  recheck
//       selectedPoints.last, // Replace with your actual point 1 coordinates
//     );
//     return duration;
//   }

  void getSuggestedRouteList() async {
    // Response response = await setMapRepo.getSuggestedRouteList();
    // if (response.statusCode == 200) {
    //   suggestedRouteList = [];
    //   suggestedRouteList.addAll(response.body);
    // } else {
    //   ApiChecker.checkApi(response);
    // }
    // update(["WhereToGoController"]);
  }

  checkPermissionBeforeNavigation(PointType pointType, context,
      {int? index}) async {
    await checkPermissionBeforeNavigate(context, () async {
      await goToScreenAndRecodeSelect(pointType, index: index);
    });
  }

  bool get isExtraPointIsEmpty => extraFocusNodes.isEmpty;

  Future<void> goToScreenAndRecodeSelect(PointType pointType,
      {int? index}) async {
    // selectedPoints.removeWhere((element) => element == defLangLng);

    Get.to(() => ChooseFromMapScreen(_getPoints))!.then((point) async {
      if (point != null) {
        if (pointType == PointType.to) {
          toRouteController.text = await getPlaceNameFromLatLng(point);
          _addToPoint(point);
        } else if (pointType == PointType.from) {
          fromRouteController.text = await getPlaceNameFromLatLng(point);
          _addFromPoint(point);
        } else if (pointType == PointType.extra) {
          extraTextEditingControllers[index!].text =
              await getPlaceNameFromLatLng(point);
          _addFirstExtraPoint(point);
        }
        update(["WhereToGoController"]);
      }
    });
  }

  List<LatLng>? get _getPoints {
    // selectedPoints.removeWhere((element) => element == defLangLng);
    extraPoints.removeWhere((element) => element == defLangLng);
    if (source == null || destination == null) {
      return null;
    } else {
      return [source!, ...extraPoints, destination!];
    }
  }

  /// ***********************SearchController********************************

  final searchServices = SearchServices();

  final searchResultsFrom = <Predictions>[].obs;

  searchPlacesFrom(String searchTerm) async {
    setState(ViewState.busy);
    searchResultsFrom.value = await searchServices.getAutoCompleteFrom(
      search: searchTerm.toString(),
    );
    // // search: searchTerm.toString(), country: 'eg');
    // print(
    //     'data ${searchResultsFrom.value} length is ${searchResultsFrom.length}');

    setState(ViewState.idle);
    update(["WhereToGoController"]);
    return searchResultsFrom;
  }

  getLocationOfSelectedSearchItem(Predictions predictions) async {
    PlaceDetail result =
        await searchServices.getPlaceDetails(predictions.placeId!);
    LatLng point = LatLng(
        result.geometry!.location!.lat!, result.geometry!.location!.lng!);
    // selectedPoints.add(point);
  }

  void handlePlaceSelection(
      String placeDescription, TextEditingController input) {
    input.text = placeDescription;
  }

  @override
  Future<String> getPlaceNameFromLatLng(LatLng latlng) async {
    return searchServices.getPlaceNameFromLatLng(latlng);
  }

  validateData() async {
    // print(" _getPoints $_getPoints ");
    if (_getPoints == null) {
      // print('no');
      OverlayHelper.showErrorToast(Get.overlayContext!, 'select_a_trip'.tr);
    } else {
      Get.find<RideController>().updateRideCurrentState(RideState.initial);
      // var dis = await distance;
      print("responseData  _getPoints! $_getPoints  ");
      Get.to(binding: BindingsBuilder(() {
        Get.lazyPut(() => RideRepo(apiClient: Get.find()));
        // ignore: avoid_single_cascade_in_expression_statements
        Get.put(BaseMapController())
          ..calculateDistance(
            _getPoints!,
          );
      }),
          () => BaseMapScreen(
                points: _getPoints!,
              ))?.then((value) {
        _clearData();
      });
      //not needed
    }
  }

  void get clearData => _clearData();
  void _clearData() {
    source = null;
    destination = null;
    fromRouteController.text = '';
    toRouteController.text = '';
    extraPoints = [];

    for (var element in extraTextEditingControllers) {
      element.text = "";
    }

    update(["WhereToGoController"]);
  }

  selectPointByPress(PointType type, AddressData data) {
    var point = LatLng(double.parse(data.lat!), double.parse(data.lng!));
    switch (type) {
      case PointType.from:
        fromRouteController.text = data.location!;

        _addFromPoint(point);
      case PointType.to:
        toRouteController.text = data.location!;
        _addToPoint(point);
      case PointType.extra:
        if (!isExtraPointsIsLengthIsOne) {
          addExtraRoute();
        }
        extraTextEditingControllers.first.text = data.location!;
        _addFirstExtraPoint(point);
    }

    update(["WhereToGoController"]);
  }

  void _addFirstExtraPoint(LatLng point) {
    if (extraPoints.isNotEmpty) {
      extraPoints.first = point;
    } else {
      extraPoints.insert(0, point);
    }
  }

  _addFromPoint(LatLng point) {
    source = point;
  }

  _addToPoint(LatLng point) {
    destination = point;
  }
}
