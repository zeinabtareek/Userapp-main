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
import '../model/search_suggestion_model.dart';
import '../model/suggested_route_model.dart';
import '../repository/search_service.dart';
import 'create_trip_controller.dart';

class WhereToGoController extends BaseController implements GetxService {
  // final SetMapRepo setMapRepo;

  WhereToGoController();
  // WhereToGoController({required this.setMapRepo});

  List<SuggestedRouteModel> suggestedRouteList = [];
  int currentExtraRoute = 0;
  bool addEntrance = false;
  final fromRouteController = TextEditingController();
  final toRouteController = TextEditingController();
  final extraRouteController = TextEditingController();
  final extraRouteController2 = TextEditingController();
  final extraRouteController3 = TextEditingController();
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
  }

  @override
  void onInit() {
    super.onInit();
    // fromRouteController.text =  address ?? "";
    // Get.put(WhereToGoController(setMapRepo: Get.find()));
  }

  List<String> extraRoutes = [];
  List<LatLng> selectedPoints = [];
  void setExtraRoute() {
    if (currentExtraRoute < 1) {
      // if (currentExtraRoute < 2) {
      // if (currentExtraRoute < 2) {
      currentExtraRoute = currentExtraRoute + 1;
      extraRoutes.add('currentExtraRoute$currentExtraRoute');
    }
    update();
  }

  void setAddEntrance() {
    addEntrance = !addEntrance;
    update();
  }

  Future<double?> calculateDistance() async {
    distance = await Get.find<CreateATripController>().calculateDistance(
      LatLng(37.7749, -122.4194), // San Francisco
      LatLng(
          37.7753, -122.4199), // Replace with your actual point 1 coordinates
    );
    return distance;
  }

  Future<double?> calculateDuration() async {
    duration = await Get.find<CreateATripController>().calculateDuration(
      LatLng(37.7749, -122.4194), // San Francisco
      LatLng(
          37.7753, -122.4199), // Replace with your actual point 1 coordinates
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

  checkPermissionBeforeNavigation(context) async {
    await checkPermissionBeforeNavigate(context, () async {
      await goToScreenAndRecodeSelect();
    });
  }

  Future<void> goToScreenAndRecodeSelect() async {
    Get.to(() => ChooseFromMapScreen(selectedPoints))!.then((point) async {
      print(" before check $point ");
      if (point != null) {
        print(" point $point ");
        selectedPoints.add(point);
        if (selectedPoints.length == 1) {
          fromRouteController.text = await getPlaceNameFromLatLng(point);
        } else if (selectedPoints.length >= 2) {
          if (currentExtraRoute == 0) {
            toRouteController.text = await getPlaceNameFromLatLng(point);
          } else {
            for (var i = 0; i < currentExtraRoute; i++) {
              extraRouteController.text = await getPlaceNameFromLatLng(point);
            }
          }
        } else {
          toRouteController.text =await getPlaceNameFromLatLng(point);
        }
      }
    });
  }

  /// ***********************SearchController********************************

  final searchServices = SearchServices();

  final searchResultsFrom = <Predictions>[].obs;

  searchPlacesFrom(String searchTerm) async {
    setState(ViewState.busy);
    searchResultsFrom.value = await searchServices.getAutoCompleteFrom(
        search: searchTerm.toString(), country: 'eg');
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


    Future<String> getPlaceNameFromLatLng(LatLng latlng) async {
      return searchServices.getPlaceNameFromLatLng(latlng);
    }

    validateData() async {
      if (fromRouteController.text == '' || toRouteController.text == '') {
        print('no');
        OverlayHelper.showErrorToast(Get.overlayContext!, 'select_a_trip'.tr);
      } else {
        print('yes');
        // Get.to(() =>
        //   MapScreen(
        //   fromScreen: 'ride',
        // ));
        Get.to(BaseMapScreen());
        //not needed
        Get.find<RideController>().updateRideCurrentState(RideState.initial);
        distance = await calculateDistance();
        update();
      }
    }
  }

