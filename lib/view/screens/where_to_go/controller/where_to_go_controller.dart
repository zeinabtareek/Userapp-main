import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/controller/base_controller.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/controller/create_trip_controller.dart';

import '../../../../helper/display_helper.dart';
import '../../../../helper/location_permission.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../choose_from_map/choose_from_map_screen.dart';
import '../../map/map_screen.dart';
import '../../ride/controller/ride_controller.dart';
import '../model/search_suggestion_model.dart';
import '../model/suggested_route_model.dart';
import '../repository/search_service.dart';
import '../repository/set_map_repo.dart';

class WhereToGoController extends BaseController implements GetxService {
  // final SetMapRepo setMapRepo;

  WhereToGoController( );
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
  final searchController=TextEditingController().obs;
  final selectedSuggestedAddress=''.obs;
  List listOfSuggestedPlaces=[
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
  List <String>extraRoutes=[];
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
    await checkPermissionBeforeNavigate(context);
  }

  /*************************SearchController*********************************/

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


  void handlePlaceSelection(String placeDescription ,TextEditingController input) {
    input.text = placeDescription;

  }


  getPlaceNameFromLatLng(LatLng latlng)async{
    await searchServices.getPlaceNameFromLatLng(latlng);
  }


  validateData() {
    if(fromRouteController.text==''||toRouteController.text==''){
      print('no');
      OverlayHelper.showErrorToast(Get.overlayContext!, 'select_a_trip'.tr);
    }
    else {
      print('yes');
      Get.to(() =>
      const MapScreen(
        fromScreen: 'ride',
      ));
      Get.find<RideController>().updateRideCurrentState(RideState.initial);
      // calculateDistance();
    }

  }

}