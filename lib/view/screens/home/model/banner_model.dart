// class BannerModel {
//   String? bannerImage;
//   String? bannerTitle;
//   String? id;
//
//   BannerModel({this.bannerImage, this.bannerTitle, this.id});
// }
class BannerModel {
  List<BannerData>? data;
  int? status;
  String? message;

  BannerModel({this.data, this.status, this.message});

  BannerModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data!.add(new BannerData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class BannerData {
  String? id;
  String? name;
  String? body;
  String? img;
  String? createdAt;

  BannerData({this.id, this.name, this.body, this.img, this.createdAt});

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    body = json['body'];
    img = json['img'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['body'] = this.body;
    data['img'] = this.img;
    data['created_at'] = this.createdAt;
    return data;
  }
}
