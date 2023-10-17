class HelpAndSupportModel {
  int? status;
  dynamic message;
  Data? data;

  HelpAndSupportModel({this.status, this.message, this.data});

  HelpAndSupportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Terms? terms;
  Terms? policy;
  About? about;

  Data({this.terms, this.policy, this.about});

  Data.fromJson(Map<String, dynamic> json) {
    terms = json['terms'] != null ? new Terms.fromJson(json['terms']) : null;
    policy = json['policy'] != null ? new Terms.fromJson(json['policy']) : null;
    about = json['about'] != null ? new About.fromJson(json['about']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.terms != null) {
      data['terms'] = this.terms!.toJson();
    }
    if (this.policy != null) {
      data['policy'] = this.policy!.toJson();
    }
    if (this.about != null) {
      data['about'] = this.about!.toJson();
    }
    return data;
  }
}

class Terms {
  int? id;
  String? key;
  String? value;
  int? isActive;
  dynamic file;
  dynamic adminId;
  String? createdAt;
  String? updatedAt;

  Terms(
      {this.id,
        this.key,
        this.value,
        this.isActive,
        this.file,
        this.adminId,
        this.createdAt,
        this.updatedAt});

  Terms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
    isActive = json['is_active'];
    file = json['file'];
    adminId = json['admin_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    data['is_active'] = this.isActive;
    data['file'] = this.file;
    data['admin_id'] = this.adminId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class About {
  Terms? email;
  Terms? phone;

  About({this.email, this.phone});

  About.fromJson(Map<String, dynamic> json) {
    email = json['email'] != null ?   Terms.fromJson(json['email']) : null;
    phone = json['phone'] != null ?   Terms.fromJson(json['phone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.email != null) {
      data['email'] = this.email!.toJson();
    }
    if (this.phone != null) {
      data['phone'] = this.phone!.toJson();
    }
    return data;
  }
}
