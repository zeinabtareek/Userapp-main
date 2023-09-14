import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/view/screens/offer/model/level_model.dart';
import 'package:ride_sharing_user_app/view/screens/profile/repository/uer_repo.dart';

class EditProfileController extends GetxController implements GetxService {
  final UserRepo userRepo;
  EditProfileController({required this.userRepo});
  //
  // XFile? _pickedProfileFile ;
  // XFile? get pickedProfileFile => _pickedProfileFile;
  //
  // XFile? _pickedIdentityImageFront ;
  // XFile? get pickedIdentityImageFront => _pickedIdentityImageFront;
  // XFile? _pickedIdentityImageBack ;
  // XFile? get pickedIdentityImageBack => _pickedIdentityImageBack;
  //
  //
  // TextEditingController nameController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController confirmPasswordController = TextEditingController();
  //
  // TextEditingController identityNumberController = TextEditingController();
  //
  //
  // FocusNode fNameNode = FocusNode();
  // FocusNode lNameNode = FocusNode();
  // FocusNode signupPhoneNode = FocusNode();
  // FocusNode signInPhoneNode = FocusNode();
  // FocusNode forgetPasswordPhoneNode = FocusNode();
  // FocusNode changePasswordPhoneNode = FocusNode();
  //
  //
  // UserModel? userModel;
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   getUserLevelInfo();
  // }
  //
  // void getUserLevelInfo() async {
  //   Response response = await userRepo.getUserLevelInfo();
  //   if (response.statusCode == 200) {
  //     userModel = response.body;
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  // }
  //
  //
  // void pickImage(bool isBack, bool isProfile) async {
  //   if(isBack){
  //     _pickedIdentityImageBack = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
  //   }else if(isProfile){
  //     _pickedProfileFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
  //   } else{
  //     _pickedIdentityImageFront = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
  //   }
  //   update();
  // }
}