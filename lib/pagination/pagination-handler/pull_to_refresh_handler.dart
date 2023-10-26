import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'pagination_handler.dart';

class PullToRefreshHandler extends Equatable implements PaginationHandler {
  RefreshController? _refreshController;
  PullToRefreshHandler() {
    setRefreshController();
  }

  setRefreshController() {
    if (_refreshController == null) {
      _refreshController = RefreshController();
    } else {
      return;
    }
  }

  RefreshController? get refreshController => _refreshController;
  @override
  void dispose() {
    _refreshController?.dispose();
  }

  @override
  void refreshCompleted() {
    _refreshController?.refreshCompleted();
  }

  @override
  void refreshFailed() {
    _refreshController?.refreshFailed();
  }

  @override
  void loadNoData() {
    _refreshController?.loadNoData();
  }

  @override
  void loadComplete() {
    _refreshController?.loadComplete();
  }

  @override
  void loadFailed() {
    _refreshController?.loadFailed();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [refreshController];
}
