  bool?  boolFromApi(dynamic val) {
    if (val is bool) {
      return val;
    } else if (val is num) {
      return val == 1;
    } else if (val is String) {
      return val == (true).toString();
    } else {
      return val;
    }
  }


