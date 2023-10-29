import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controller/pagination_controller.dart';
import '../state/pagination_bloc_state.dart';
import '../use-case/main_paginate_list_use_case.dart';

/// class PaginationListView<UseCase extends MainPaginateApiUseCase, Entity,
/// PaginationListItem extends PaginationViewItem> extends StatelessWidget
class PaginationListView<UseCase extends MainPaginateListUseCase, Entity,
        ItemView extends PaginationViewItem>
    extends GetView<PaginationController<UseCase, Entity>> {
  final ItemView Function(Entity entity) child;
  const PaginationListView({
    super.key,
    required this.child,
    this.listPadding,
  });

  final EdgeInsetsGeometry? listPadding;
  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<PaginationBloc<UseCase, Entity>, PaginationBlocState>(
    //   buildWhen: (previous, current) => previous != current,
    //   newMethod(),
    // );

    return controller.obx((state) {
      if (state is PaginationLoading) {
        return Container(
          height: 500,
          width: 500,
          alignment: Alignment.center,
          // TODO:  loadingWidget
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          // child: const LoadingWidget(),
        );
      }
      if (state is PaginationError) {
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is PaginationLoaded && state.items.isNotEmpty) {
        return ListView.separated(
          padding: listPadding,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            Entity item = state.items[index];
            return child(item);
          },
          itemCount: state.items.length,
        );
      }

      if (state is PaginationLoaded && state.items.isEmpty ||
          state is PaginationNoDataFoundState) {
        // TODO:  NoDataFoundWidget
        return const Center(child: Text("NoDataFound"));
      }
      if (state is PaginationBlocInitial) {
        // TODO:
        return const Center(child: Text("PaginationBlocInitial"));
      }
      if (state is PaginationNoMoreData && state.items.isNotEmpty) {
        return ListView.separated(
          padding: listPadding,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            Entity item = state.items[index];
            return child(item);
          },
          itemCount: state.items.length,
        );
      }

      return const SizedBox();
    });
  }
}

/// abstract class PaginationViewItem<Entity> extends StatelessWidget
abstract class PaginationViewItem<Entity> extends StatelessWidget {
  final Entity data;
  const PaginationViewItem({
    super.key,
    required this.data,
  });
}

/// class PaginationListView<UseCase extends MainPaginateApiUseCase, Entity,
/// ItemView extends PaginationViewItem> extends StatelessWidget
class PaginationListViewInTabBar<UseCase extends MainPaginateListUseCase,
        Entity, ItemView extends PaginationViewItem>
    extends GetView<PaginationController<UseCase, Entity>> {
  final ItemView Function(Entity entity) child;
  final EdgeInsetsGeometry? listPadding;

  final Widget Function(Widget list) paginatedLst;
  const PaginationListViewInTabBar({
    super.key,
    required this.child,
    required this.paginatedLst,
    this.listPadding,
  });

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      if (state is PaginationLoading) {
        return Container(
          height: 500,
          width: 500,
          alignment: Alignment.center,
          // TODO:  loadingWidget
          // child: const LoadingWidget(),
          child: const Center(
            child: CupertinoActivityIndicator(),
          ),
        );
      }
      if (state is PaginationError) {
        return const Center(child: Icon(Icons.error));
      }
      if (state is PaginationLoaded && state.items.isNotEmpty) {
        return paginatedLst(
          ListView.separated(
            padding: listPadding,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              Entity item = state.items[index];
              return child(item);
            },
            itemCount: state.items.length,
          ),
        );
      }

      if (state is PaginationLoaded && state.items.isEmpty ||
          state is PaginationNoDataFoundState) {
        // TODO:  NoDataFoundWidget
        return const Center(child: Text("NoDataFound"));
      }
      if (state is PaginationBlocInitial) {
        // TODO:
        return const Center(child: Text("PaginationBlocInitial"));
      }
      if (state is PaginationNoMoreData && state.items.isNotEmpty) {
        paginatedLst(
          ListView.separated(
            padding: listPadding,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              Entity item = state.items[index];
              return child(item);
            },
            itemCount: state.items.length,
          ),
        );
      }

      return const SizedBox();
    });
  }
}

/// this widget was cereted for tapBar
/// which has problem in case using one SmartRefresher for many taps

class SmartRefresherApp<A extends PaginationController>
    extends StatelessWidget {
  final A controller;
  final Widget list;
  const SmartRefresherApp({
    super.key,
    required this.controller,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      key: key,
      controller: controller.refreshController!,
      enablePullDown: true,
      enablePullUp: true,
      onLoading: controller.loadMore,
      onRefresh: controller.onRefreshData,
      child: list,
    );
  }
}

/// class PaginationListView<UseCase extends MainPaginateApiUseCase, Entity,
/// PaginationListItem extends PaginationViewItem> extends StatelessWidget
class PaginationChatListView<UseCase extends MainPaginateListUseCase, Entity,
        ItemView extends PaginationViewItem>
    extends GetView<PaginationController<UseCase, Entity>> {
  final ItemView Function(Entity entity) child;
  const PaginationChatListView({
    super.key,
    required this.child,
    this.listPadding,
  });

  final EdgeInsetsGeometry? listPadding;
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      if (state is PaginationLoading) {
        return Container(
          height: 500,
          width: 500,
          alignment: Alignment.center,
          // TODO:  loadingWidget
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          // child: const LoadingWidget(),
        );
      }
      if (state is PaginationError) {
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is PaginationLoaded && state.items.isNotEmpty) {
        var items = state.items.reversed.toList();
        return Builder(builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              controller.moveScrollToMaxScrollExtent();
            },
          );
          return ListView.separated(
            controller: controller.scrollController,
            shrinkWrap: true,
            padding: kMaterialListPadding,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              Entity item = items[index];
              return child(item);
            },
            itemCount: items.length,
          );
        });
      }

      if (state is PaginationLoaded && state.items.isEmpty ||
          state is PaginationNoDataFoundState) {
        // TODO:  NoDataFoundWidget
        return const Center(child: Text("NoDataFound"));
      }
      if (state is PaginationBlocInitial) {
        // TODO:
        return const Center(child: Text("PaginationBlocInitial"));
      }
      if (state is PaginationNoMoreData && state.items.isNotEmpty) {
        return Builder(builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              controller.moveScrollToMaxScrollExtent();
            },
          );
          return ListView.separated(
            controller: controller.scrollController,
            padding: listPadding,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              Entity item = state.items[index];
              return child(item);
            },
            itemCount: state.items.length,
          );
        });
      }

      return const SizedBox();
    });
  }
}
