// pagination_handler
abstract class PaginationHandler {
  void dispose();
  void refreshCompleted();
  void refreshFailed();
  void loadNoData();
  void loadComplete();
  void loadFailed();
}
