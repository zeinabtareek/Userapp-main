class StatusTimes {
  StatusTimes({
      this.status, 
      this.time,});

  StatusTimes.fromJson(dynamic json) {
    status = json['status'];
    time = json['time'];
  }
  String ?status;
  String ?time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['time'] = time;
    return map;
  }

}