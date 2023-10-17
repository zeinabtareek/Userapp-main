


class AddressModel {
  int? status;
  List<AddressData>? data;

  AddressModel({this.status, this.data});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      status: json['status'],
      data: json['data'] != null
          ? List<AddressData>.from(
          json['data'].map((x) => AddressData.fromJson(x)))
          : null,
    );
  }
   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressData {
  String? id;
  String? name;
  String? location;
  String? lat;
  String? lng;

  AddressData({this.id, this.name, this.location, this.lat, this.lng});

  AddressData.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      name = json['name'];
      location = json['location'];
      lat = json['lat'] ?? ""; // Handle null values by assigning an empty string
      lng = json['lng'] ?? ""; // Handle null values by assigning an empty string
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
