// ignore_for_file: prefer_final_fields

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../authenticate/data_state.dart';
import '../model/pagination_api_model.dart';
import '../pagination-handler/pull_to_refresh_handler.dart';
import '../state/pagination_bloc_state.dart';
import '../use-case/main_paginate_list_use_case.dart';

class PaginationController<PaginateApiUseCase extends MainPaginateListUseCase,
    Entity> extends GetxController with StateMixin<PaginationBlocState> {
  PaginateApiUseCase useCase;

  PaginationApiModel pagination = PaginationApiModel();
  List<Entity> items = [];

  late RefreshController? _refreshController;

  RefreshController? get refreshController => _refreshController;

  RefreshController? refreshControllerr;

  PullToRefreshHandler? _handler;

  final ScrollController scrollController = ScrollController();

  PaginationController(this.useCase, {this.refreshControllerr});

  @override
  onInit() async {
    change(PaginationBlocInitial(), status: RxStatus.success());
    _handler = PullToRefreshHandler();
    _refreshController = refreshControllerr ?? _handler?.refreshController;
    _restData();
    onRefreshData();
    super.onInit();
  }

  @override
  onClose() {
    _handler?.dispose();
    scrollController.dispose();
    super.onClose();
  }

  bool get canRefresh => pagination.hasPrevious == true;

  bool get canFetchMore => pagination.hasNext == true;

  _restData() {
    _handler!.refreshController!.headerMode!.value = RefreshStatus.idle;
    _handler!.refreshController!.footerMode!.value = LoadStatus.idle;
    pagination.page = 1;
    pagination.hasPrevious = false;
    items.clear();
  }

  moveScrollToMaxScrollExtent() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 300,
      duration: const Duration(milliseconds: 80),
      curve: Curves.bounceIn,
    );
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
    // });
  }

  void get restData => _restData();
  onRefreshData({Function()? onLoadSucses}) async {
    change(PaginationLoading(), status: RxStatus.success());

    _restData();
    await _handelRes(
      onSusses: () {
        _handler?.refreshCompleted();
        // onLoadSucses?.call();
        change(PaginationLoaded<Entity>(items), status: RxStatus.success());
        // emit(PaginationLoaded<Entity>(items));

        //  moveScrollToMaxScrollExtent();
      },
      onError: (error) {
        _handler?.refreshFailed();

        // emit(PaginationError(
        //     error ?? AppGlobalConstants.notFoundDataDefaultMsg));
        change(
          PaginationError(
            // todo
            // error ?? AppGlobalConstants.notFoundDataDefaultMsg,
            "${error}",
            // "notFoundData",
          ),
          status: RxStatus.success(),
        );
      },
      onNoMoreData: () {
        _handler?.loadNoData();
        change(
          PaginationLoaded(items),
          status: RxStatus.success(),
        );
      },
      onEmptyResList: () {
        change(
          PaginationNoDataFoundState(),
          status: RxStatus.success(),
        );
      },
    );

    update();
  }
  // }

  loadMore() async {
    if (!canFetchMore) {
      _handler?.loadNoData();
      // change(
      //   PaginationNoMoreData(items),
      //   status: RxStatus.success(),
      // );
    } else {
      pagination.page = pagination.page! + 1;
      await _handelRes(
        onSusses: () {
          _handler?.loadComplete();
          change(
            PaginationLoaded<Entity>(items),
            status: RxStatus.success(),
          );
        },
        onError: (error) {
          _handler?.loadFailed();
          print(" _h ");
          change(
            const PaginationError(
                // error ?? AppGlobalConstants.notFoundDataDefaultMsg,
                // TODO:
                "no data found"),
            status: RxStatus.success(),
          );
        },
        onNoMoreData: () {
          _handler?.loadNoData();
          change(
            PaginationLoaded(items),
            status: RxStatus.success(),
          );
        },
        onEmptyResList: () {
          // TODO:  show toast here no data found
        },
      );
    }
    update();
  }

  _handelRes({
    Function()? onSusses,
    Function(String? error)? onError,
    Function()? onNoMoreData,
    Function()? onEmptyResList,
  }) async {
    try {
      var res = await useCase.call(parm: useCase.setPage(pagination.page!));

      final isReturnData = res.data != null && (res is DataSuccess);
      if (!isReturnData) {
        onError?.call(res.error?.message);
      } else {
        _handelSucsesCase(
          res,
          onNoMoreData: () => onNoMoreData?.call(),
          onSusses: () => onSusses?.call(),
          onEmptyResList: () => onEmptyResList?.call(),
        );
        onSusses?.call();
      }
    } on DioException catch (e) {
      onError?.call(e.toString());
    } catch (e) {
      onError?.call(e.toString());
    }
  }

  _handelSucsesCase(
    DataState<(PaginationApiModel, List<dynamic>)> res, {
    Function()? onNoMoreData,
    Function()? onSusses,
    Function()? onEmptyResList,
  }) {
    pagination = res.data!.$1;
    var resList = res.data?.$2;

    resList = resList?.cast<Entity>() ?? <Entity>[];

    if (resList.isEmpty) {
      onEmptyResList?.call();
      return;
    }

    if (items.isNotEmpty) {
      items = items + (resList as List<Entity>);
    } else {
      items = (resList as List<Entity>);
    }
    if (pagination.hasNext == false) {
      onNoMoreData?.call();
      return;
    }
    onSusses?.call();
  }

  void get showEmptyScreen => _showEmptyScreen();
  _showEmptyScreen() {
    change(
      PaginationBlocInitial(),
      status: RxStatus.success(),
    );
  }

  void get showLoadingScreen => _showLoadingScreen();
  _showLoadingScreen() {
    change(
      PaginationLoading(),
      status: RxStatus.success(),
    );
  }
}
