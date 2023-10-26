import 'package:intl/intl.dart';

import '../../../../../../pagination/model/main_paginate_request_entity_model.dart';

enum StateValue {
  current,
  cancel,
  finished,
}

class GetTripReqModel extends MainPaginateRequestEntityModel {
  StateValue? normalFilterValue;
  String? from;
  String? to;

  GetTripReqModel(
    super.page, {
    this.normalFilterValue,
    this.from,
    this.to,
  });

  String filterKey = 'status';

  Map<String, dynamic> get filterMap => {
        filterKey: "${normalFilterValue?.name}",
        if (from != null) "from": "$from",
        if (to != null) "to": "$to",
      };

  GetTripReqModel copyWith({
    int page = 1,
    StateValue? normalFilterValue,
    String? from,
    String? to,
  }) {
    return GetTripReqModel(
      page,
      normalFilterValue: normalFilterValue ?? this.normalFilterValue,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> get toApiMapQuery {
    return super.toMap()..addAll(filterMap);
  }

  var dateFormat = DateFormat("yyyy-M-d H:m:s");

  GetTripReqModel addStartEndDate(DateTime start, DateTime end) {
    from = dateFormat.format(start);
    to = dateFormat.format(end);
    page = 1;
    return this;
  }

  clearDatesFilter() {
    from = null;
    to = null;
    page = 1;
  }
}
