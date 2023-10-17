import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/authenticate/data/models/res-models/user_model.dart';
import 'package:ride_sharing_user_app/authenticate/domain/use-cases/auth_cases.dart';
import 'package:ride_sharing_user_app/helper/di_container.dart';

import '../enum/view_state.dart';
import '../helper/logger/logger.dart';
import '../initialize_dependencies.dart';
import '../util/action_center/action_center.dart';
import '../view/widgets/error_widget.dart';

class BaseController extends GetxController {
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

  @override
  void onInit() async {
    if (await sl<AuthCases>().isAuthenticated()) {
      user = await getUser;
      update();
      refresh();
    }

    super.onInit();
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
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (ctx.state == ViewState.noDate) {
          return Center(child: Text(emptyWord));
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