class SignUpBody {
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;
  String? confirmPassword;
  String? address;
  String? identityNumber;

  SignUpBody({this.fName, this.lName, this.phone, this.email='',
    this.password, this.confirmPassword , this.address, this.identityNumber});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
    email = json['email'];
    address = json['address'];
    identityNumber = json['identity_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    data['email'] = email;
    data['address'] = address;
    data['identity_number'] = identityNumber;
    return data;
  }
}