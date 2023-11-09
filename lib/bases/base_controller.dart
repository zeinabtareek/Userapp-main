import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/authenticate/data/models/res-models/user_model.dart';
import 'package:ride_sharing_user_app/authenticate/domain/use-cases/auth_cases.dart';

import '../enum/view_state.dart';
import '../helper/logger/logger.dart';
import '../initialize_dependencies.dart';
import '../mxins/map/map_view_helper.dart';
import '../util/action_center/action_center.dart';
import '../view/screens/where_to_go/repository/search_service.dart';
import '../view/widgets/custom_loading.dart';
import '../view/widgets/custom_no_data.dart';
import '../view/widgets/error_widget.dart';

class BaseController extends GetxController with MapHelper {
  final _state = ViewState.idle.obs;

  ViewState get state => _state.value;
  String stateId = 'stateId';

  setState(ViewState state, {String? id}) {
    _state.value = state;
    if (id != null) {
      update([id]);
    } else {
      update([stateId]);
    }
    debugPrint(" state ::: ${state.name}   id ${id ?? stateId}");
  }

  final ActionCenter _actionCenter = ActionCenter(Get.find<AbsLogger>());
  ActionCenter get actionCenter => _actionCenter;

  setUser(UserAuthModel? user) => sl<AuthCases>().setUserDate(user);

  UserAuthModel? user;
  Future<UserAuthModel?> get getUser async =>
      user = await sl<AuthCases>().getUserData();

  String? myAddressString;
  var currntLoction ;
  @override
  void onInit() async {
    await getUser;

    update();
    refresh();


    super.onInit();
  }

  Future<String> getPlaceNameFromLatLng(LatLng latlng) async {
    return SearchServices().getPlaceNameFromLatLng(latlng);
  }
}

class BaseStateWidget<T extends BaseController> extends StatelessWidget {
  final String emptyWord;
  final Widget successWidget;
  final Function()? onPressedRetryButton;
  final String? id;
  final Widget? errorStateWidget;
  final Function(GetBuilderState<T> k)? initState;
  const BaseStateWidget({
    super.key,
    required this.successWidget,
    required this.onPressedRetryButton,
    this.emptyWord = '',
    this.id,
    this.errorStateWidget,
    this.initState,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      id: id ?? "stateId",
      // init: T?.c(),

      initState: (_) {
        initState?.call(_);

        // if (!Get.isRegistered<T>()) {
        //   Get.put(T);
        // }
      },
      builder: (ctx) {
        if (ctx.state == ViewState.busy) {
// TODO:Loading Widget
//           return const Center(
//             child: CupertinoActivityIndicator(),
//           );
        return customLoading();
        } else if (ctx.state == ViewState.noDate) {
          return   customNoDataWidget();
          // return Center(child: Text(emptyWord));
        } else if (ctx.state == ViewState.idle) {
          return successWidget;
        } else if (ctx.state == ViewState.error) {
          return errorStateWidget ??
              errorWidget(onPressed: onPressedRetryButton);
        } else {
          print(" 000000 ");
          return const SizedBox();
        }
      },
    );
  }
}
/*
Obx(() {
        if (activityController.state == ViewState.busy) {
          return const Center(child: CupertinoActivityIndicator(),);
        } else if (activityController.model.data == null ||
            activityController.model.data!.isEmpty||
            activityController.model.data==[]) {
          return   Center(child: Text(Strings.noHistory.tr));
        } else {
          return
            ListView.builder(
              itemBuilder: (context, index) {
                return ActivityItemView(
                  activityItemModel: activityController.model.data![index],
                  isDetailsScreen: false,
                );
              },
              itemCount: activityController.model.data!.length,
              padding: EdgeInsets.zero,
            );
        }
      })
 */