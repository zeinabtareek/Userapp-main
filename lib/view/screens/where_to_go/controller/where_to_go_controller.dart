
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/controller/base_controller.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';

import '../../../../helper/display_helper.dart';
import '../../../../helper/location_permission.dart';
import '../../../../util/app_strings.dart';
import '../../choose_from_map/choose_from_map_screen.dart';
import '../model/search_suggestion_model.dart';
import '../model/suggested_route_model.dart';
import '../repository/search_service.dart';
import '../repository/set_map_repo.dart';

class WhereToGoController extends BaseController implements GetxService{
  final SetMapRepo setMapRepo;

  WhereToGoController({required this.setMapRepo});

  List<SuggestedRouteModel> suggestedRouteList = [];
  int currentExtraRoute = 0;
  bool addEntrance = false;
  final fromRouteController = TextEditingController();
  final toRouteController = TextEditingController();
  final extraRouteController = TextEditingController();
  final entranceController = TextEditingController();
  final entranceNode=FocusNode();
  final fromNode=FocusNode();
  final extraNode=FocusNode();
  final toRoutNode=FocusNode();
  @override
  void onInit() {
    
    super.onInit();

  }
  void setExtraRoute(){
    if(currentExtraRoute < 2){
      currentExtraRoute = currentExtraRoute + 1;
    }

    update();
  }

  void setAddEntrance(){
    addEntrance = !addEntrance;
    update();
  }

  void getSuggestedRouteList() async {
    Response response = await setMapRepo.getSuggestedRouteList();
    if (response.statusCode == 200) {
      suggestedRouteList = [];
      suggestedRouteList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  checkPermissionBeforeNavigation(context)async{

     await checkPermissionBeforeNavigate(context);

  }


  /*************************SearchController*********************************/

  final searchServices=SearchServices();



  final searchResultsFrom=<Suggestion>[].obs;
  searchPlacesFrom(String searchTerm )async{
    setState(ViewState.busy);
      searchResultsFrom.value=  await searchServices.getAutoCompleteFrom(  search:searchTerm.toString(),country: 'eg' );
    print('data ${searchResultsFrom.value} length is ${searchResultsFrom.length}');
    setState(ViewState.idle);
    update();
    return searchResultsFrom;


  }


}