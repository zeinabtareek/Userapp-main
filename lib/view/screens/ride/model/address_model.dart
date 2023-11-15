import '../../home/controller/address_controller.dart';

class AddressModel {
  int? status;
  List<AddressData>? data;

  AddressModel({this.status, this.data});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      status: json['status'],
      data: json['data'] != null
          ? List<AddressData>.from(
              json['data'].map(
                (x) => AddressData.fromJson(
                  x,
                ),
              ),
            )
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
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
  String? icon;

  bool isUpdate = false;

  AddressData({
    this.id,
    this.name,
    this.location,
    this.lat,
    this.lng,
    this.icon,
  }) {
    icon = name != null ? AddressController.getAddressIconByName(name!) : null;
  }

  toUpdate() {
    isUpdate = true;
    return this;
  }

  AddressData.fromJson(
    Map<String, dynamic>? json,
  ) {
    if (json != null) {
      id = json['id'];
      name = json['name'];
      location = json['location'];
      lat =
          json['lat'] ?? ""; // Handle null values by assigning an empty string
      lng =
          json['lng'] ?? ""; // Handle null values by assigning an empty string

      icon =
          name != null ? AddressController.getAddressIconByName(name!) : null;
    }
  }

  bool get isHaveData => id != null;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['lat'] = lat;
    data['lng'] = lng;
    if (isUpdate) {
      data['_method'] = "PUT";
    }
    return data;
  }

  Map<String, dynamic> toUpdateJson() {
    toUpdate();
    return toJson();
  }

  factory AddressData.createEmpty(String name) {
    return AddressData(
        name: name, icon: AddressController.getAddressIconByName(name));
  }

  @override
  String toString() {
    return 'AddressData(id: $id, name: $name, location: $location, lat: $lat, lng: $lng, icon: $icon, isUpdate: $isUpdate)';
  }
}
