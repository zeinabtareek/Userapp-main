class PaginationApiModel {
  int? page, totalPages, totalResults;
  bool? hasNext, hasPrevious;
  PaginationApiModel({
    this.totalResults,
    this.hasPrevious = true,
    this.page = 1,
    this.hasNext = true,
    this.totalPages,
  });

  factory PaginationApiModel.fromJson(Map<String, dynamic> map) {
    
    return PaginationApiModel(
      totalResults: map['total'],
      hasPrevious:  (1 < map["current_page"]),
      page: map["current_page"],
      hasNext: (map["current_page"] < map['last_page'])&& map["current_page"]!= map['last_page'],
      totalPages: map['last_page'],
    );
  }
}
