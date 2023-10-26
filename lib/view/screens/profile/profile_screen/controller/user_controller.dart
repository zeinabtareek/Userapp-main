import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/view/screens/offer/model/level_model.dart';

class UserController extends BaseController implements GetxService {
  UserController();
  String defaultDailCode = "+966";
  XFile? _pickedProfileFile;
  XFile? get pickedProfileFile => _pickedProfileFile;

  XFile? _pickedIdentityImageFront;
  XFile? get pickedIdentityImageFront => _pickedIdentityImageFront;
  XFile? _pickedIdentityImageBack;
  XFile? get pickedIdentityImageBack => _pickedIdentityImageBack;

  TextEditingController fristNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController identityNumberController = TextEditingController();

  FocusNode fNameNode = FocusNode();
  FocusNode lNameNode = FocusNode();
  FocusNode signupPhoneNode = FocusNode();
  FocusNode signInPhoneNode = FocusNode();
  FocusNode forgetPasswordPhoneNode = FocusNode();
  FocusNode changePasswordPhoneNode = FocusNode();

  UserModel? userModel;

  bool isEnabledForEdit = false;
  collectData() async {
    await getUser;

    if (user != null) {
      // print(" user ::: ${user?.toMap()} ");
      fristNameController.text = user!.firstName!;
      lastNameController.text = user!.lastName!;
      phoneController.text = user!.phoneCode! + user!.phone!;
      defaultDailCode = user!.phoneCode!;
      emailController.text = user!.email??"";
      addressController.text = user!.address??"";
      update();
    }
  }

  switchEdit(bool state) {
    isEnabledForEdit = state;
    update();
  }

  enableEdit() {
    switchEdit(true);
  }

  disableEdit() {
    switchEdit(false);
  }

  @override
  void onInit() async {
    await collectData();
    super.onInit();
  }

  void pickImage(bool isBack, bool isProfile) async {
    if (isBack) {
      _pickedIdentityImageBack =
          (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    } else if (isProfile) {
      _pickedProfileFile =
          (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    } else {
      _pickedIdentityImageFront =
          (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    }
    update();
  }
}
