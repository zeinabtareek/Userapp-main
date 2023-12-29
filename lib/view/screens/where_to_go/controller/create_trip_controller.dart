import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../enum/payment_enum.dart';
import '../../../../enum/request_states.dart';
import '../../../../enum/view_state.dart';
import '../../../../mxins/map/map_view_helper.dart';
import '../../../../util/action_center/exceptions.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../request_screens/controller/base_map_controller.dart';
import '../../request_screens/model/order/OrderModel.dart';
import '../../ride/controller/ride_controller.dart';
import '../model/create_order_body.dart';
import '../model/order_create.dart';
import '../repository/create_trip_repo.dart';
import '../repository/search_service.dart';

class CreateATripController extends BaseMapController {
  final services = CreateTripRepo();

  CreateOrderModel createOrderModel = CreateOrderModel();

  @override
  void onInit() async {
    // await listonOnNotificationSocketAfterAccept();
    super.onInit();
  }

  String? get packageId => Get.find<RideController>().selectedPackage.value?.id;

  String? get note => Get.find<RideController>().noteController.text;
  String? get vehicleTypeId =>
      Get.find<RideController>().selectedSubPackage.value?.id;

  String? get paymentType => Get.find<RideController>().initialSelectItem.value;
  String? get promoCode => Get.find<RideController>().promoCode;

  Future<List<ExtraRoutes>> extraRoutes(List<LatLng> allTripPoint) async {
    var to = allTripPoint.removeLast();
    var from = allTripPoint.removeAt(0);

    List<ExtraRoutes> extraRoute = [];
    if (allTripPoint.isNotEmpty) {
      for (var element in allTripPoint) {
        extraRoute.add(
          ExtraRoutes(
              lat: element.latitude.toString(),
              lng: element.longitude.toString(),
              location: await getPlaceNameFromLatLng(element)),
        );
      }
    } else {
      extraRoute = [];
    }
    allTripPoint.insert(0, from);
    allTripPoint.add(to);
    return extraRoute;
  }

  Future<List<ExtraRoutes>> googleRoutes(
    LatLng source,
    List<LatLng> extraPoint,
    LatLng destination,
  ) async {
    List<ExtraRoutes> list = [];

    if (extraPoint.isEmpty) {
      var resList =
          await FlutterPolylinePointsHelper.getRouteBetweenCoordinates(
              AppConstants.mapKey,
              source.latitude,
              source.longitude,
              destination.latitude,
              destination.longitude);

      for (var element in resList.points) {
        list.add(
          ExtraRoutes(
              lat: element.latitude.toString(),
              lng: element.longitude.toString(),
              location: ""
              //  await getPlaceNameFromLatLng(element.toLatLng),
              ),
        );
      }
      return list;
    } else {
      extraPoint.insert(0, source);
      extraPoint.add(destination);

      for (var i = 0; i < extraPoint.length - 1; i++) {
        // if ((i + 1) <= extraPoint.length) {
        var resList =
            await FlutterPolylinePointsHelper.getRouteBetweenCoordinates(
                AppConstants.mapKey,
                extraPoint[i].latitude,
                extraPoint[i].longitude,
                extraPoint[i + 1].latitude,
                extraPoint[i + 1].longitude);

        for (var element in resList.points) {
          list.add(
            ExtraRoutes(
                lat: element.latitude.toString(),
                lng: element.longitude.toString(),
                location: ""
                //  await getPlaceNameFromLatLng(element.toLatLng),
                ),
          );
        }
        // }
      }
      return list;
    }
  }

  Future<From> _form(LatLng source) async {
    return From(
        lat: source.latitude.toString(),
        lng: source.longitude.toString(),
        location: await getPlaceNameFromLatLng(source));
  }

  Future<To> _to(LatLng destination) async {
    return To(
      lat: destination.latitude.toString(),
      lng: destination.longitude.toString(),
      location: await getPlaceNameFromLatLng(destination),
    );
  }

  ///create a trip function
  RxBool isLoadingCreateATrip = false.obs;
  Future<CreateOrderModel> createATrip(List<LatLng> points,
      // {required String promoCode}
      ) async {
    LatLng source = points.first; // Example source coordinate (San Francisco)
    LatLng destination = points.last;

    List<ExtraRoutes> extraRoute = await extraRoutes(points);
    String time = "12";
    //  await calculateDuration(source, destination);

    List<ExtraRoutes> gogleR = await googleRoutes(
      source,
      extraRoute.isNotEmpty
          ? extraRoute
              .map((e) => LatLng(double.parse(e.lat), double.parse(e.lng)))
              .toList()
          : [],
      destination,
    );
    print('payment $paymentType');
    try {
      var result = await actionCenter.execute(() async {
        setState(ViewState.busy);
        isLoadingCreateATrip(true);

        createOrderModel = await services.createATrip(
          createOrderBody: CreateOrderBody(
            promoCode:promoCode??'' ,
            orderType: 'trip',
            packageId: packageId,
            from: await _form(source),
            to: await _to(destination),
            extraRoutes: extraRoute,
             time: Get.find<BaseMapController>().durationValue.toString(),
            distance: num.parse(
                Get.find<BaseMapController>().distance.value.toString()),
            note: note,
            vehicleTypeId: vehicleTypeId,
            paymentType: paymentType,
            googleRoutes: gogleR,
          ),
        );
        orderId = createOrderModel.data!.id!;
        // print('order ::::  id $orderId');

        setOrderId(orderId!);
        Get.find<RideController>()
            .updateRideCurrentState(RideState.findingRider);

        // print('new trip data   ${createOrderModel.data?.id}');

        Get.find<BaseMapController>().key.currentState!.contract();
        Get.find<BaseMapController>()
            .changeState(request[RequestState.findDriverState]!);
        Get.find<BaseMapController>().update();
        setState(ViewState.idle);
        await _checkThePaymentMethod(createOrderModel.data?.finalPrice);
        isLoadingCreateATrip(false);
      }, checkConnection: true);

      if (!result) {
        setState(ViewState.error);
        print(" ::: error");
        isLoadingCreateATrip(false);
      }

      return createOrderModel; // Return the acceptedOrderData object
    } on CustomException catch (e) {
      OverlayHelper.showErrorToast(Get.overlayContext!, e.message);
    }
    //
    throw Exception("Unexpected error occurred");
  }


  _checkThePaymentMethod(totalPrice) async {
    PaymentTypeState selectedPaymentType = enumFromString(paymentType ?? '');

    if (selectedPaymentType == PaymentTypeState.wallet) {
      ///Zeinab this is ::: Condition when the payment method is wallet

      print('this is wallet');
      var minWallet =
          double.parse(user?.wallet.toString() ?? '0.0') - totalPrice;
      OverlayHelper.showSuccessToast(Get.overlayContext!,
          '${'your_wallet_now_is'.tr} ${minWallet.ceil().toInt()}');
    } else {
      print('this isn\'t wallet');
    }
  }

  @override
  Future<String> getPlaceNameFromLatLng(LatLng latlng) async {
    return SearchServices().getPlaceNameFromLatLng(latlng);
  }

// calculate
  ///Cancel trip
  cancelATrip({orderId}) async {
    try {
      var result = await actionCenter.execute(() async {
        setState(ViewState.busy);
        var result = await services.cancelATrip(orderId: getOrderId());
        print(result);
        setOrderId(null);
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
  OrderModel orderModel = OrderModel();
  // showTrip() async {
  //   try {
  //     var result = await actionCenter.execute(() async {
  //       setState(ViewState.busy);
  // showTrip({orderId}) async {
  //   try {
  //     var result = await actionCenter.execute(() async {
  //  setState(ViewState.busy);
  showTrip({orderId}) async {
    try {
      var result = await actionCenter.execute(() async {
        setState(ViewState.busy);

        // orderModel = await services.showTripDetails(orderId: );
        orderModel = await services.showTripDetails(orderId: orderId);



        // orderModel = await services.showTripDetails(
        //     orderId:
        //     'b0a49d66-14e2-4236-bf1b-771e1f84a2fc'
        // // Get.find<BaseMapController>().changeState(request[RequestState.riderDetailsState]!);//riderDetailsState
        // );
        print('driver first name ${orderModel.data?.driver?.firstName}');
        print(orderModel.data?.vehicleType?.id);
        // print(orderModel.data);
        setState(ViewState.idle);
        setState(ViewState.idle);
      }, checkConnection: true);

      if (!result) {
        setState(ViewState.error);
        print(" ::: error");
      }
      return orderModel; // Return the acceptedOrderData object
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
