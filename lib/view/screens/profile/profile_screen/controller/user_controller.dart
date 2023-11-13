import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../authenticate/data/models/res-models/user_model.dart';
import '../../../../../bases/base_controller.dart';
import '../../../../../util/ui/overlay_helper.dart';
import '../../../offer/model/level_model.dart';
import '../../model/edit_profile_req_model.dart';
import '../../repository/uer_repo.dart';

class UserController extends BaseController implements GetxService {
  UserRepo? userRepo;
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

  bool isEnabledForEdit = true;

  RxBool isCanUpdate = false.obs;
  GlobalKey<FormState> editProfileScreenKey = GlobalKey<FormState>();

  collectData() async {
    await getUser;

    if (user != null) {
      // print(" user ::: ${user?.toMap()} ");
      isCanUpdate(false);
      fristNameController.text = user!.firstName!;
      lastNameController.text = user!.lastName!;
      phoneController.text = user!.phoneCode! + user!.phone!;
      defaultDailCode = user!.phoneCode!;
      emailController.text = user!.email ?? "";
      addressController.text = user!.address ?? "";
      // _pickedProfileFile = XFile(File.fromUri(Uri.parse(user!.img!)).path);
      update();
    }
  }

  @override
  void onInit() async {
    await collectData();
    userRepo = UserRepo();
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

  RxBool isLoading = false.obs;
  submitEdit() async {
    actionCenter.execute(() async {
      if (!validate()) return;

      final req = EditProfileReqModel(
        fName: fristNameController.text,
        lName: lastNameController.text,
        address: addressController.text,
        email: emailController.text,
        img: _pickedProfileFile != null ? File(_pickedProfileFile!.path) : null,
      );
      isLoading(true);
      final res = await userRepo?.updateProfile(req);

      isLoading(false);
      if (res is UserAuthModel) {
        var token = user!.tkn;

        await setUser(
          res.copyWith(token: token),
        );
        await getUser;
        update();
        refresh();
        OverlayHelper.showSuccessToast(Get.overlayContext!, "Success");
        Get.back();
      }
    }, checkConnection: true);
  }

  bool validate() {
    return editProfileScreenKey.currentState!.validate();
  }
}
