import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../bases/base_controller.dart';
import '../../../../enum/view_state.dart';
import '../../../../helper/location_permission.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../choose_from_map/choose_from_map_screen.dart';
import '../../request_screens/screens/base_map/base_map_screen.dart';
import '../../ride/controller/ride_controller.dart';
import '../../ride/repository/ride_repo.dart';
import '../model/search_suggestion_model.dart';
import '../model/suggested_route_model.dart';
import '../repository/search_service.dart';
import 'create_trip_controller.dart';

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
  final extraNode = FocusNode();
  final extraNode2 = FocusNode();
  var distance;
  var duration;
  final extraNode3 = FocusNode();
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
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
    fromRouteController.clear();
    for (var element in [
      fromRouteController,
      fromNode,
      toRoutNode,
      toRouteController,
      extraNode,
      extraNode2,
      extraNode3,
      ...extraTextEditingControllers,
      ...extraFocusNodes,
    ]) {
      element.dispose();
    }
  }

  // List<String> extraRoutes = [];

  List<LatLng> extraPoints = [];

  LatLng get defLangLng => const LatLng(0, 0);

  List<LatLng> selectedPoints = [];

  List<TextEditingController> extraTextEditingControllers = [];

  List<FocusNode> extraFocusNodes = [];
  int get currentExtraRouteLength => extraTextEditingControllers.length;

  bool get isExtraPointsIsLengthIsOne => extraFocusNodes.length == 1;

  void addExtraRoute() {
    extraTextEditingControllers.add(TextEditingController());
    extraFocusNodes.add(FocusNode());
    update();
  }

  void removeExtraRoute({int? index}) {
    if (index != null) {
      extraTextEditingControllers.removeAt(index);
      extraFocusNodes.removeAt(index);
    } else {
      extraTextEditingControllers.removeLast();
      extraFocusNodes.removeLast();
    }
    update();
  }

  void setAddEntrance() {
    addEntrance = !addEntrance;
    update();
  }

  Future<double?> calculateDistance() async {
    distance = await Get.find<CreateATripController>().calculateDistance(
      selectedPoints.first,
// TODO:  recheck
      selectedPoints.last, // Replace with your actual point 1 coordinates
    );
    return distance;
  }

  Future<double?> calculateDuration() async {
    duration = await Get.find<CreateATripController>().calculateDuration(
      selectedPoints.first,
// TODO:  recheck
      selectedPoints.last, // Replace with your actual point 1 coordinates
    );
    return duration;
  }

  void getSuggestedRouteList() async {
    // Response response = await setMapRepo.getSuggestedRouteList();
    // if (response.statusCode == 200) {
    //   suggestedRouteList = [];
    //   suggestedRouteList.addAll(response.body);
    // } else {
    //   ApiChecker.checkApi(response);
    // }
    // update();
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
    selectedPoints.removeWhere((element) => element == defLangLng);

    Get.to(() => ChooseFromMapScreen(_getPoints))!.then((point) async {
      if (point != null) {
        if (pointType == PointType.to) {
          toRouteController.text = await getPlaceNameFromLatLng(point);
          if (selectedPoints.isNotEmpty) {
            selectedPoints.add(point);
          } else {
            selectedPoints.insert(0, defLangLng);
            selectedPoints.add(point);
          }
        } else if (pointType == PointType.from) {
          fromRouteController.text = await getPlaceNameFromLatLng(point);
          if (selectedPoints.isNotEmpty) {
            selectedPoints.insert(0, point);
          } else {
            selectedPoints.insert(0, point);
            selectedPoints.add(defLangLng);
          }
        } else if (pointType == PointType.extra) {
          extraTextEditingControllers[index!].text =
              await getPlaceNameFromLatLng(point);
          extraPoints.insert(index, point);

        }
        update();
      }
    });
  }

  List<LatLng>? get _getPoints {
    if (selectedPoints.isEmpty) {
      return null;
    } else if (selectedPoints.length == 2) {
      return selectedPoints;
    } else {
      return [selectedPoints.first, ...extraPoints, selectedPoints.last];
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
    // search: searchTerm.toString(), country: 'eg');
    print(
        'data ${searchResultsFrom.value} length is ${searchResultsFrom.length}');
    setState(ViewState.idle);
    update();
    return searchResultsFrom;
  }

  getLocationOfSelectedSearchItem(Predictions predictions) async {
    PlaceDetail result =
        await searchServices.getPlaceDetails(predictions.placeId!);
    LatLng point = LatLng(
        result.geometry!.location!.lat!, result.geometry!.location!.lng!);
    selectedPoints.add(point);
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
      // print('yes');
      // Get.to(() =>
      //   MapScreen(
      //   fromScreen: 'ride',
      // ));
      Get.to(binding: BindingsBuilder(() {
        Get.lazyPut(() => RideRepo(apiClient: Get.find()));
      }),
          () => BaseMapScreen(
                points: _getPoints!,
              ))?.then((value) {
        selectedPoints = [];
        fromRouteController.text = '';
        toRouteController.text = '';
        extraPoints = [];

        for (var element in extraTextEditingControllers) {
          element.text = "";
        }

        update();
      });
      //not needed
      Get.find<RideController>().updateRideCurrentState(RideState.initial);
      distance = await calculateDistance();
      update();
    }
  }
}
