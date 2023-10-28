import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/model/order_create.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../enum/request_states.dart';
import '../../../../enum/view_state.dart';
import '../../../../util/action_center/exceptions.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../map/map_screen.dart';
import '../../request_screens/controller/base_map_controller.dart';
import '../../request_screens/model/order/OrderModel.dart';
import '../../request_screens/model/order_model.dart';
import '../../ride/controller/ride_controller.dart';
import '../model/create_order_body.dart';
import '../repository/create_trip_repo.dart';
import '../repository/search_service.dart';

class CreateATripController extends BaseController {
  final services = CreateTripRepo();

  CreateOrderModel createOrderModel = CreateOrderModel();

  ///create a trip function
  Future<CreateOrderModel> createATrip() async {
    List<ExtraRoutes> extraRoutes = [
      ExtraRoutes(lat: '21.123', lng: '21.124', location: 'Location 1'),
      ExtraRoutes(lat: '21.125', lng: '21.126', location: 'Location 2'),
      ExtraRoutes(lat: '21.127', lng: '21.128', location: 'Location 3'),
    ];
    LatLng source = const LatLng(
        37.7749, -122.4194); // Example source coordinate (San Francisco)
    LatLng destination = LatLng(34.0522, -118.2437);
    dynamic distance = await calculateDistance(source, destination);
    List<ExtraRoutes> googleRoutes = [];
    try {
      var result = await actionCenter.execute(() async {
        setState(ViewState.busy);

        createOrderModel = await services.createATrip(
            createOrderBody: CreateOrderBody(
              orderType: 'trip',
              packageId: Get
                  .find<RideController>()
                  .selectedPackage
                  .value
                  ?.id,
              from: From(
                  lat: '21.23443', lng: '23.32323', location: 'Nasr City'),
              to: To(lat: '21.23443', lng: '23.32323', location: 'Nasr City'),
              extraRoutes: extraRoutes,
              time: '12',
              distance: num.parse(distance.toString()),
              note: Get
                  .find<RideController>()
                  .noteController
                  .text,
              vehicleTypeId: Get
                  .find<RideController>()
                  .selectedSubPackage
                  .value
                  ?.id,
              // vehicleTypeId: '3ddb3780-fb2b-40b4-823f-283d51edc828',
              paymentType: Get
                  .find<RideController>()
                  .initialSelectItem ,
              // paymentType: 'cash',
              googleRoutes: extraRoutes,
             ));

        Get.find<RideController>()
            .updateRideCurrentState(RideState.findingRider);
        print('new trip data   ${createOrderModel.data?.id}');

        Get.find<BaseMapController>()
            .  key.currentState!.contract();
        Get.find<BaseMapController>()
            .changeState(request[RequestState.findDriverState]!);
         Get.find<BaseMapController>().update();
        setState(ViewState.idle);
      }, checkConnection: true);

      if (!result) {
        setState(ViewState.error);
        print(" ::: error");
      }

      return createOrderModel; // Return the acceptedOrderData object
    } on CustomException catch (e) {
      OverlayHelper.showErrorToast(Get.overlayContext!, e.message);
    }

    throw Exception(
        "Unexpected error occurred"); // Throw an exception if none of the catch blocks are executed
    update();
  }


  ///calculate Distance
  calculateDistance(LatLng source, LatLng dis) async {
    double sourceLatitude = source.latitude ?? 0.0;
    double sourceLongitude = source.longitude ?? 0.0;
    double disLatitude = dis.latitude ?? 0.0;
    double disLongitude = dis.longitude ?? 0.0;
    final result = await SearchServices.getDistance(
      LatLng(sourceLatitude, sourceLongitude),
      LatLng(disLatitude, disLongitude),
    );
    print('result $result');
    return result;  // return distance;
  }  ///calculate duration

  calculateDuration(LatLng source, LatLng dis) async {


    double sourceLatitude = source.latitude ?? 0.0;
    double sourceLongitude = source.longitude ?? 0.0;
    double disLatitude = dis.latitude ?? 0.0;
    double disLongitude = dis.longitude ?? 0.0;
    final result = await SearchServices.getDistanceAndDuration(LatLng(sourceLatitude, sourceLongitude),
      LatLng(disLatitude, disLongitude),);
     final duration = result['duration'];
     print('Duration: $duration');
  }

// calculate
  ///Cancel trip
  cancelATrip({orderId}) async {
    try {
      var result = await actionCenter.execute(() async {
        setState(ViewState.busy);
       var result= await services.cancelATrip(orderId: orderId);
        print(result);

        setState(ViewState.idle);
      }, checkConnection: true);

      if (!result) {
        setState(ViewState.error);
        print(" ::: error");
      }
    } on CustomException catch (e) {
      OverlayHelper.showErrorToast(Get.overlayContext!, e.message);
      }
    }

 ///show trip
  OrderModel orderModel=OrderModel();
  showTrip({orderId})async{
     try {
       var result = await actionCenter.execute(() async {
         setState(ViewState.busy);

           orderModel=
           await services.showTripDetails(orderId:'b0a49d66-14e2-4236-bf1b-771e1f84a2fc');
         // Get.find<BaseMapController>().changeState(request[RequestState.riderDetailsState]!);//riderDetailsState
         print(orderModel.data?.driver);
         print(orderModel.data?.vehicleType?.id);
         // print(orderModel.data);
    setState(ViewState.idle);
         setState(ViewState.idle);
       }, checkConnection: true);

       if (!result) {
         setState(ViewState.error);
         print(" ::: error");
       }      return  orderModel; // Return the acceptedOrderData object
     } on CustomException catch (e) {
       OverlayHelper.showErrorToast(Get.overlayContext!, e.message);
     }
}


  Future<void> launchUrlFun(String url, bool isMail) async {
    if (!await launchUrl(Uri.parse(isMail ? params.toString() : url))) {
      throw 'Could not launch $url';
    }
  }

  final Uri params = Uri(
    scheme: 'mailto',
    path: 'test@gmail.com',
    query: 'subject=support Feedback&body=',
  );



}
