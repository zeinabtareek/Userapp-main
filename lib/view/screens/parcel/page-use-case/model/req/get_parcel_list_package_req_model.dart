import 'package:intl/intl.dart';

import '../../../../../../pagination/model/main_paginate_request_entity_model.dart';

enum ParcelStateValue { on_its_way, cancel, delivered, current }
// get_parcel_list_package_req_model
class GetParcelListPackageReqModel extends MainPaginateRequestEntityModel {
  ParcelStateValue? normalFilterValue;
  String? orderId;
  String? from;
  String? to;

  GetParcelListPackageReqModel(
    super.page, {
    this.normalFilterValue,
    this.from,
    this.to,
  });

  String filterStateKey = 'status';
  String filterOrderIdKey = 'order_num';

  Map<String, dynamic> get filterMap {
    return {
      ...orderId == null
          ? {
              filterStateKey: "${normalFilterValue?.name}",
              if (from != null) "from": "$from",
              if (to != null) "to": "$to",
            }
          : {
              filterOrderIdKey: orderId,
            }
    };
  }

  GetParcelListPackageReqModel copyWith({
    int page = 1,
    ParcelStateValue? normalFilterValue,
    String? from,
    String? to,
  }) {
    return GetParcelListPackageReqModel(
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

  GetParcelListPackageReqModel addStartEndDate(DateTime start, DateTime end) {
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
