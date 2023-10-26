abstract class MainPaginateRequestEntity<T> {
  int? reqPage;
  Map<String, dynamic>? map;
  MainPaginateRequestEntity(this.reqPage, {this.map});



  T? query;

  Map<String, dynamic> toMap() {
    return {
      "page": reqPage,
      ...(map ?? {}),
    };
  }
}
