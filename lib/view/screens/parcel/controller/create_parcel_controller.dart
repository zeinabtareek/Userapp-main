


import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/controller/parcel_controller.dart';

import '../../../../enum/request_states.dart';
import '../../../../enum/view_state.dart';
import '../../../../util/action_center/exceptions.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../choose_from_map/choose_from_map_screen.dart';
import '../../request_screens/controller/base_map_controller.dart';
import '../../ride/controller/ride_controller.dart';
import '../../where_to_go/model/order_create.dart';
import '../../where_to_go/repository/create_trip_repo.dart';
import '../model/create_parcel_body.dart';
import '../model/create_parcel_response.dart';
import '../repository/parcel_repo.dart';

class CreateParcelController extends BaseController{
  final ParcelRepo parcelRepo;
  CreateParcelController({required this.parcelRepo});


  CreateParcelModel createParcelModel=CreateParcelModel();
  // LatLng? source;
  // LatLng? destination;

  String? get packageId => Get.find<RideController>().selectedPackage.value?.id;
  // Future<From> _form(LatLng source) async {
  //   return From(
  //       lat: source.latitude.toString(),
  //       lng: source.longitude.toString(),
  //       location: await getPlaceNameFromLatLng(source));
  // }
  //
  // Future<To> _to(LatLng destination) async {
  //   return To(
  //     lat: destination.latitude.toString(),
  //     lng: destination.longitude.toString(),
  //     location: await getPlaceNameFromLatLng(destination),
  //   );
  // }
  // _addFromPoint(LatLng point) {
  //   source = point;
  // }
  //
  // _addToPoint(LatLng point) {
  //   destination = point;
  // }
//   createParcel( List<LatLng> points )async{
//     // await  parcelRepo.createAParcel(createParcelBody: null);
//     LatLng source = points.first; // Example source coordinate (San Francisco)
//     LatLng destination = points.last;
// ///change this
//     String time = "12";
//     try {
//       // var result = await actionCenter.execute(() async {
//       //   setState(ViewState.busy);
//         // isLoadingCreateATrip(true);
//
//         createParcelModel = await parcelRepo.createAParcel(
//           createParcelBody: CreateParcelBody(
//             orderType: 'parcel',
//             packageId: packageId,
//             // from: await _form(source),
//             to: await _to(destination),
//             from:
//
//
//             time: time,
//             distance: 33,
//             note: '',
//
//             paymentType: 'cash',
//             googleRoutes: [],
//           ),
//         );
//         print('new trip data   ${createParcelModel.data?.id}');
//
//
//         setState(ViewState.idle);
//       //  isLoadingCreateATrip(false);
//       // }, checkConnection: true);
//       //
//       // if (!result) {
//       //   setState(ViewState.error);
//       //   print(" ::: error");
//        // isLoadingCreateATrip(false);
//       // }
//
//       return createParcelModel; // Return the acceptedOrderData object
//     } on CustomException catch (e) {
//       OverlayHelper.showErrorToast(Get.overlayContext!, e.message);
//     }
//
//     throw Exception(
//         "Unexpected error occurred"); // Throw an exception if none of the catch blocks are executed
//   }



}