import 'dart:async';
import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../bases/base_controller.dart';
import '../../../../enum/view_state.dart';
import '../../../../mxins/map/map_view_helper.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/images.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../where_to_go/model/search_suggestion_model.dart';
import '../../where_to_go/repository/search_service.dart';
import '../../where_to_go/where_to_go_screen.dart';
import '../use-case/check_region_use_case.dart';

class ChooseFromMapController extends BaseController
    with MapViewHelper, MapHelper {
  List<LatLng> pickedPoints = [
    // const LatLng(37.421998189179185, -122.08399951457977),
    // const LatLng(37.41511878640148, -122.0886980742216),
    // const LatLng(37.416753550576935, -122.07783814519644)
  ];

  Timer? _debounce;

  final CheckRegionUseCase checkRegionUseCase = CheckRegionUseCase();

  @override
  void onInit() async {
    await _getCurrantLocation();
    await _drawMarkersIfHavePickedPoints();
    await _moveCameraToMyLocation(
        point: pickedPoints.isNotEmpty ? pickedPoints.first : null);
    await _drawPolylineIfHavePickedPoints();

    super.onInit();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  final searchController = TextEditingController();
  final searchDesTextEditing = TextEditingController();

  final carouselController = CarouselController();
  SearchServices services = SearchServices();

  double distance = 0.0;
  late Position _position;
  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  Position get position => _position;

  LatLng _initialPosition = const LatLng(23.83721, 90.363715);

  LatLng get initialPosition => _initialPosition;
  final address = ''.obs;
  final isDataLoading = false.obs;
  final RxBool isContainerVisible = false.obs;

  void toggleContainerVisibility() {
    isContainerVisible.value = !isContainerVisible.value;
    if (isContainerVisible.isFalse) {
      searchController.clear();
    }
  }

  Future _getCurrantLocation() async {
    try {
      _position = (await MapHelper.getCurrentPosition())!;
      _initialPosition = LatLng(_position.latitude, _position.longitude);
      _checkRegin(_initialPosition);
    } on Exception {
      // TODO
    }
  }

  Future<void> _moveCameraToMyLocation({LatLng? point}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    double zoom = pickedPoints.isNotEmpty
        ? calculateZoomLevel(pickedPoints.first, pickedPoints.last)
        : 13;
    goToPlaceByCamera(
      controller: _mapController!,
      lat: point?.latitude ?? _position.latitude,
      lng: point?.longitude ?? _position.longitude,
      update,
      zoom: zoom,
      // zoom: 15,
    );
  }

  Future<void> _drawMarkersIfHavePickedPoints() async {
    if (pickedPoints.isNotEmpty) {
      List<RippleMarker> markers = [];
      for (var element in pickedPoints) {
        markers.add(RippleMarker(
          markerId: MarkerId(pickedPoints.indexOf(element).toString()),
          position: element,
          ripple: false,
          icon: BitmapDescriptor.fromBytes(
              await getBytesFromAsset(Images.locationFill, 50)),
          onTap: () {},
        ));
      }

      addListMarker(update, markers: markers);
    }
  }

  Future _drawPolylineIfHavePickedPoints() async {
    for (var i = 0; i < pickedPoints.length; i++) {
      if (i + 1 < pickedPoints.length) {
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
  }

  Color generateRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256), // Red value (0-255)
      random.nextInt(256), // Green value (0-255)
      random.nextInt(256), // Blue value (0-255)
      1.0, // Alpha (transparency) value (0.0-1.0)
    );
  }

  onCameraIdle() async {
    isDataLoading.value = true;
    if (mapController != null) {
      LatLngBounds bounds = await mapController!.getVisibleRegion();
      final lon = (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
      final lat = (bounds.northeast.latitude + bounds.southwest.latitude) / 2;

      address.value = await services.getPlaceNameFromLatLng(LatLng(lat, lon));
      print('address is : ${address.value}');
    }
    isDataLoading.value = false;
  }

  ///needs to be refactored
  StreamSubscription<ServiceStatus> serviceStatusStream =
      Geolocator.getServiceStatusStream().listen((ServiceStatus status) async {
    try {
      print(status);
      LocationPermission permission;

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openAppSettings();
        // await Geolocator.openLocationSettings();
        // await openLocationSettings();
        Get.back();
        Get.defaultDialog(
            content: const Text(
          'Location services are disabled. Please enable the services.....',
          style: TextStyle(fontSize: 16),
        ));
        Get.back();
        return;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.back();
          Get.defaultDialog(
              content: const Text(
            'Location permissions are denied',
            style: TextStyle(fontSize: 16),
          ));
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        Get.back();

        Get.defaultDialog(
            content: const Text(
          'Location permissions are permanently denied, we cannot request permissions **.',
          style: TextStyle(fontSize: 16),
        ));
        Get.off(SetDestinationScreen(
          fromCat: false,
        ));
        // Get.off(AddItemScreen(address: '', apartmentNumber: '', landMark: '', lat: '', lng: '', areaNumber: ''));
        return;
      }
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        // markers.clear();
        // markers=[];

        return await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high)
            .then((currLocation) async {
          // initialPosition = LatLng(currLocation.latitude, currLocation.longitude);
          // currentLocation=LatLng(currLocation.latitude, currLocation.longitude);
          // await getUserLocation(LatLng(currLocation.latitude, currLocation.longitude));
          // await   showPinsOnMap(LatLng(currLocation.latitude, currLocation.longitude));
          print(currLocation.longitude);

          Get.to(SetDestinationScreen(
            fromCat: false,
          ));
        });
      }
    } on TimeoutException {
      Get.defaultDialog(
          content: const Text(
        'Location request timed out.',
        style: TextStyle(fontSize: 12),
      ));
    } on PermissionDeniedException {
      Get.defaultDialog(
          content: const Text(
        'Location permissions are denied.',
        style: TextStyle(fontSize: 12),
      ));
    } on LocationServiceDisabledException {
      Get.defaultDialog(
          content: const Text(
        'Location services are disabled.',
        style: TextStyle(fontSize: 12),
      ));
    } on PermissionRequestInProgressException {
      Get.defaultDialog(
          content: const Text(
        'Location Permission Request InProgress Exception  .',
        style: TextStyle(fontSize: 12),
      ));
    }
  });
  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
    // mapViewHelperMapController = mapController;
    // _mapCompleter = Completer<GoogleMapController>()..complete(mapController);
  }

  onMapCreated(gController) {
    setMapController(gController);
    _getCurrantLocation();

  }

  onCameraMove(CameraPosition position) {
    print(position.target);
    // _moveCameraToMyLocation(point: position.target);

    selectedPoint = position.target;
    debounceFunction(
      () async {
        if (!await _checkRegin(selectedPoint!)) {
          selectedPoint = null;
          isSetDestBtnViable.value = false;
          refresh();
          update();
        } else {
          isSetDestBtnViable.value = true;
        }
      },
    );
  }

  final searchServices = SearchServices();

  final searchResultsFrom = <Predictions>[].obs;

  debounceFunction(Function() action) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      action();
    });
  }

  searchPlacesFrom(String searchTerm) async {
    setState(ViewState.busy);
    searchResultsFrom.value = await searchServices.getAutoCompleteFrom(
      search: searchTerm.toString(),
    );
    // search: searchTerm.toString(), country: 'eg');

    setState(ViewState.idle);
    update();
    return searchResultsFrom;
  }

  LatLng? selectedPoint;

  RxnBool isSetDestBtnViable = RxnBool(true);
  getLocationOfSelectedSearchItem(Predictions predictions) async {
    searchController.text = predictions.description.toString();
    searchResultsFrom.value = [];
    refresh();
    address("");
    PlaceDetail result =
        await searchServices.getPlaceDetails(predictions.placeId!);
    print(" result ${result.toString()} ");
    selectedPoint = LatLng(
        result.geometry!.location!.lat!, result.geometry!.location!.lng!);
    _moveCameraToMyLocation(point: selectedPoint);
    debounceFunction(
      () async {
        if (!await _checkRegin(selectedPoint!)) {
          selectedPoint = null;
          searchResultsFrom.clear();
          isSetDestBtnViable.value = false;
          searchResultsFrom.value = [];
          refresh();
          update();
        } else {
          isSetDestBtnViable.value = true;
        }
      },
    );
  }

  Future<bool> _checkRegin(LatLng point) async {
    bool resState = true;
    bool state = await actionCenter.execute(() async {
      try {
        var res =
            await checkRegionUseCase.call(point.latitude, point.longitude);

        if (res.status != 200) {
          OverlayHelper.showErrorToast(
            Get.overlayContext!,
            res.msg ?? "",
          );
          resState = false;
        } else {
          resState = true;
        }
      } catch (e) {
        OverlayHelper.showErrorToast(
            Get.overlayContext!, "region not available");
        resState = false;
      }
    }, checkConnection: true);
    if (state) {
      return resState;
    } else {
      return state;
    }
  }
}
