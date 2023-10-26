import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/view/screens/choose_from_map/choose_from_map_screen.dart';

import '../../../../enum/view_state.dart';
import '../../../../helper/location_permission.dart';
import '../model/search_suggestion_model.dart';
import '../model/suggested_route_model.dart';
import '../repository/search_service.dart';

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
  final extraNode3 = FocusNode();
  final toRoutNode = FocusNode();
  final searchController = TextEditingController().obs;

  List<LatLng> selectedPoints = [];

  List<String> extraRoutes = [];
  void setExtraRoute() {
    if (currentExtraRoute < 1) {
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
          // toRouteController.text =await getPlaceNameFromLatLng(point);
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
}
