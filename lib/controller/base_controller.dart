import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enum/view_state.dart';

class BaseController extends GetxController {
  final _state = ViewState.idle.obs;

  ViewState get state => _state.value;
  String stateId = 'stateId';

  setState(ViewState state) {
    _state.value = state;
    update([stateId]);
  }
}

class BaseStateWidget<T extends BaseController> extends StatelessWidget {

  final String emptyWord;
  final Widget successWidget;
  const BaseStateWidget({
    super.key,
   
    required this.successWidget,
    this.emptyWord = '',
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      id: 'stateId',
      // init: T?.c(),
      initState: (_) {},
      builder: (ctx) {
        if (ctx.state == ViewState.busy) {
// TODO:
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (ctx.state==ViewState.noDate) {
          return Center(child: Text(emptyWord));
        } else if (ctx.state == ViewState.idle) {
          return successWidget;
        } else {
          return SizedBox();
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