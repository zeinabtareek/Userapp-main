import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/history/model/activity_item_model.dart';
import 'package:ride_sharing_user_app/view/screens/history/repository/history_repo.dart';

import '../../../../enum/view_state.dart';
import '../model/history_model.dart';

class ActivityController extends  BaseController
    with SingleGetTickerProviderMixin
    implements GetxService {
  // final ActivityRepo activityRepo;
  // ActivityController({required this.activityRepo});
  // ActivityRepo activityRepo = ActivityRepo();

  final List<String> _filterList = ['all', 'today', 'yesterday', 'custom'];

  List<String> get filterList => _filterList;

  List<ActivityItemModel> activityItemList = [];
  bool _showCustomDate = false;
  bool get showCustomDate => _showCustomDate;
  String _filterStartDate = '';
  String get filterStartDate => _filterStartDate;

  String _filterEndDate = '';
  String get filterEndDate => _filterEndDate;

  late TabController tabController;

  late LatLng _initialPosition = const LatLng(23.83721, 90.363715);
  LatLng get initialPosition => _initialPosition;

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;
  Completer<GoogleMapController> mapCompleter =
      Completer<GoogleMapController>();

  ///polyline and marker
  Map<PolylineId, Polyline> polyLines = {};
  Set<Marker> markers = Set<Marker>();

  @override
  onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    // await activityRepo.getAllHistoryTrips();
    // await getAllHistoryTrips();
  }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updateShowCustomDateState(bool state) {
    _showCustomDate = state;
    update();
  }

  void setFilterDateRangeValue({String? start, String? end}) {
    _filterStartDate = start ?? "";
    _filterEndDate = end ?? "";
    update();
  }

  ///Api Fetch
  //
  // HistoryModel model = HistoryModel();
  // // final loading=false.obs;
  // getAllHistoryTrips() async {
  //   setState(ViewState.busy);
  //   model = await activityRepo.getAllHistoryTrips();
  //   if (model.data != null && (model.data?.isNotEmpty ?? false)) {
  //     setState(ViewState.idle);
  //   } else {
  //     setState(ViewState.noDate);
  //   }
  // }

  ///animate camera move
  //   Future<void> goToPlace({
  //     required double lat,
  //     required double lng,
  //   }) async {
  //     final GoogleMapController controller = await mapCompleter.future;
  //     await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //         // bearing: 192.8334901395799,
  //         target: LatLng(lat, lng),
  //
  //         zoom: 19))
  //     );
  //   }

  Future<void> goToPlace(
    Completer<GoogleMapController> _controller, {
    required double lat,
    required double lng,
  }) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 192.8334901395799, target: LatLng(lat, lng), zoom: 19)));
    showPinsOnMap(LatLng(lat, lng), LatLng(lat, lng));
    update();
  }

  ///show pins on the map
  showPinsOnMap(LatLng sourcePoint, LatLng desPoint) {
    try {
      markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: sourcePoint,
          onTap: () {}));
      markers.add(Marker(
          markerId: MarkerId(
            'destination',
          ),
          position: desPoint,
          onTap: () {}));
      // setPolylines(point,desPoint);
      update();
    } catch (e) {
      printError(info: '############no#########');
    }
  }

  ///set Polylines on a map
  setPolylines(LatLng sourcePoint, LatLng desPoint) {}

  ///on Camera Move
  onCameraMove(CameraPosition position) {
    _initialPosition = position.target;
    update();
  }
}
