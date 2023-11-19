


import 'package:ride_sharing_user_app/bases/base_controller.dart';

import '../../../../util/action_center/exceptions.dart';
import '../../../../util/app_constants.dart';
import '../../where_to_go/repository/create_trip_repo.dart';
import '../model/create_parcel_body.dart';
import '../model/create_parcel_response.dart';
import '../repository/parcel_repo.dart';

class CreateParcelController extends BaseController{
  final services = ParcelRepo();


  //
  // Future<List<ExtraRoutes>> googleRoutes(
  //     LatLng source,
  //     List<LatLng> extraPoint,
  //     LatLng destination,
  //     ) async {
  //   List<ExtraRoutes> list = [];
  //
  //   if (extraPoint.isEmpty) {
  //     var resList =
  //     await FlutterPolylinePointsHelper.getRouteBetweenCoordinates(
  //         AppConstants.mapKey,
  //         source.latitude,
  //         source.longitude,
  //         destination.latitude,
  //         destination.longitude);
  //
  //     for (var element in resList.points) {
  //       list.add(
  //         ExtraRoutes(
  //             lat: element.latitude.toString(),
  //             lng: element.longitude.toString(),
  //             location: ""
  //           //  await getPlaceNameFromLatLng(element.toLatLng),
  //         ),
  //       );
  //     }
  //     return list;
  //   } else {
  //     extraPoint.insert(0, source);
  //     extraPoint.add(destination);
  //
  //     for (var i = 0; i < extraPoint.length; i++) {
  //       if ((i + 1) <= extraPoint.length) {
  //         var resList =
  //         await FlutterPolylinePointsHelper.getRouteBetweenCoordinates(
  //             AppConstants.mapKey,
  //             extraPoint[i].latitude,
  //             extraPoint[i].longitude,
  //             extraPoint[i + 1].latitude,
  //             extraPoint[i + 1].longitude);
  //
  //         for (var element in resList.points) {
  //           list.add(
  //             ExtraRoutes(
  //                 lat: element.latitude.toString(),
  //                 lng: element.longitude.toString(),
  //                 location: ""
  //               //  await getPlaceNameFromLatLng(element.toLatLng),
  //             ),
  //           );
  //         }
  //       }
  //     }
  //     return list;
  //   }
  // }
  // Future<CreateParcelModel> createATrip( ) async {
  //   // LatLng source = points.first; // Example source coordinate (San Francisco)
  //   // LatLng destination = points.last;
  //   //
  //   // List<ExtraRoutes> extraRoute = await extraRoutes(points);
  //   // String time = "12";
  //   //  await calculateDuration(source, destination);
  //
  //   List<ExtraRoutes> gogleR = await googleRoutes(
  //     source,
  //     extraRoute.isNotEmpty
  //         ? extraRoute
  //         .map((e) => LatLng(double.parse(e.lat), double.parse(e.lng)))
  //         .toList()
  //         : [],
  //     destination,
  //   );
  //
  //   try {
  //     var result = await actionCenter.execute(() async {
  //       setState(ViewState.busy);
  //       isLoadingCreateATrip(true);
  //
  //       createOrderModel = await services.createATrip(
  //         createOrderBody: CreateOrderBody(
  //           orderType: 'trip',
  //           packageId: packageId,
  //           from: await _form(source),
  //           to: await _to(destination),
  //           extraRoutes: extraRoute,
  //           time: time,
  //           distance: num.parse(distance.value.toString()),
  //           note: note,
  //           vehicleTypeId: vehicleTypeId,
  //           paymentType: paymentType,
  //           googleRoutes: gogleR,
  //         ),
  //       );
  //       orderId = createOrderModel.data!.id!;
  //       print('order ::::  id $orderId');
  //
  //       setOrderId(orderId!);
  //       Get.find<RideController>()
  //           .updateRideCurrentState(RideState.findingRider);
  //       print('new trip data   ${createOrderModel.data?.id}');
  //
  //       Get.find<BaseMapController>().key.currentState!.contract();
  //       Get.find<BaseMapController>()
  //           .changeState(request[RequestState.findDriverState]!);
  //       Get.find<BaseMapController>().update();
  //       setState(ViewState.idle);
  //       isLoadingCreateATrip(false);
  //     }, checkConnection: true);
  //
  //     if (!result) {
  //       setState(ViewState.error);
  //       print(" ::: error");
  //       isLoadingCreateATrip(false);
  //     }
  //
  //     return createOrderModel; // Return the acceptedOrderData object
  //   } on CustomException catch (e) {
  //     OverlayHelper.showErrorToast(Get.overlayContext!, e.message);
  //   }
  //
  //   throw Exception(
  //       "Unexpected error occurred"); // Throw an exception if none of the catch blocks are executed
  //   update();
  // }

}