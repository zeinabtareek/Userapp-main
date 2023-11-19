





class DistanceModel {
  DistanceModel({
    this.destinationAddresses,
    this.originAddresses,
    this.rows,
    this.status,});

  DistanceModel.fromJson(dynamic json) {
    destinationAddresses = json['destination_addresses'] != null ? json['destination_addresses'].cast<String>() : [];
    originAddresses = json['origin_addresses'] != null ? json['origin_addresses'].cast<String>() : [];
    if (json['rows'] != null) {
      rows = [];
      json['rows'].forEach((v) {
        rows?.add(Rows.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<String>? destinationAddresses;
  List<String>? originAddresses;
  List<Rows>? rows;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['destination_addresses'] = destinationAddresses;
    map['origin_addresses'] = originAddresses;
    if (rows != null) {
      map['rows'] = rows?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }
  double ?get distance=>rows?.first.elements?.first.distance?.value?.toDouble();

}

class Rows {
  Rows({
    this.elements,});

  Rows.fromJson(dynamic json) {
    if (json['elements'] != null) {
      elements = [];
      json['elements'].forEach((v) {
        elements?.add(Elements.fromJson(v));
      });
    }
  }
  List<Elements>? elements;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (elements != null) {
      map['elements'] = elements?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Elements {
  Elements({
    this.distance,
    this.duration,
    this.status,});

  Elements.fromJson(dynamic json) {
    distance = json['distance'] != null ? Distance.fromJson(json['distance']) : null;
    duration = json['duration'] != null ? Durations.fromJson(json['duration']) : null;
    status = json['status'];
  }
  Distance? distance;
  Durations? duration;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (distance != null) {
      map['distance'] = distance?.toJson();
    }
    if (duration != null) {
      map['duration'] = duration?.toJson();
    }
    map['status'] = status;
    return map;
  }

}

class Durations {
  Durations({
    this.text,
    this.value,});

  Durations.fromJson(dynamic json) {
    text = json['text'];
    value = json['value'];
  }
  String? text;
  int? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['value'] = value;
    return map;
  }

}

class Distance {
  Distance({
    this.text,
    this.value,});

  Distance.fromJson(dynamic json) {
    text = json['text'];
    value = json['value'];
  }
  String? text;
  int? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['value'] = value;
    return map;
  }

}