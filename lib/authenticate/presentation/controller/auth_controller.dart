import 'dart:io';

import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/display_helper.dart';
import '../../../util/app_strings.dart';
import '../../../view/screens/auth/additional_sign_up_screen.dart';
import '../../../view/screens/dashboard/bottom_menu_controller.dart';
import '../../../view/screens/dashboard/dashboard_screen.dart';
import '../../../view/screens/html/html_viewer_screen.dart';
import '../../data/models/req-model/login_with_pass_req_model.dart';
import '../../data/models/req-model/register_req_model.dart';
import '../../data/models/req-model/send_otp_req_model.dart';
import '../../domain/use-cases/auth_cases.dart';
import '../../enums/auth_enums.dart';
import '../forgot_password/forget_password_screen.dart';
import '../forgot_password/verification_screen.dart';
import '../login-with-otp/otp_log_in_screen.dart';
import '../sign-up/sign_up_screen.dart';

class AuthController extends GetxController {
  /// login
  TextEditingController LoginPhoneController = TextEditingController();
  TextEditingController LoginPassController = TextEditingController();
  Rx<CountryCode> LoginSelectCountry = CountryCode.fromDialCode("+20").obs;
  AuthCases authCases;

  AuthController(
    this.authCases,
  );
  toForgetPassScreen() {
    // Get.toNamed(AuthScreenPath.forgetPasswordScreenRouteName);
    Get.to(() => const ForgotPasswordScreen());
  }

  toLoginOtpScreen() {
    // TODO:
    Get.to(() => const OtpLoginScreen(
          otpState: OtpState.loginWithOtp,
        ));
  }

  toSignUpScreen() {
    // TODO:
    Get.to(
      () => const SignUpScreen(),
    );
  }

  toHtmlViewer() {
    Get.to(() => const HtmlViewerScreen());
  }

  RxBool isLoginWithPassLoading = false.obs;

  void loginWithPass() async {
    if (LoginPhoneController.text.length < 8) {
      showCustomSnackBar(Strings.invalidPhone.tr);
    } else if (LoginPassController.text.isEmpty) {
      showCustomSnackBar(Strings.passIsRequired.tr);
    } else if (LoginPassController.text.length < 8) {
      showCustomSnackBar(Strings.minimumPassLength.tr);
    } else {
      isLoginWithPassLoading(true);

      final res = await authCases.loginWithPassword(
        LoginWithPassReqModel(
          password: LoginPassController.text,
          phone: LoginPhoneController.text,
          countryCode: LoginSelectCountry.value.dialCode!,
        ),
      );
      isLoginWithPassLoading(false);
      if (res.data!.isSuccess) {
        // Success Action

// TODO:
        /*
          if (_isActiveRememberMe) {
      
      saveUserNumberAndPassword(phone, password);
    } else {
      clearUserNumberAndPassword();
    }

  
        
         */
        Get.find<BottomMenuController>().resetNavBar();
        Get.offAll(() => DashboardScreen());
      } else {
        // fail Action
        showCustomSnackBar(res.data?.msg ?? "");
      }
    }
  }

  RxBool LoginRememberMe = false.obs;

  toggleRememberMe() {
    LoginRememberMe.value = LoginRememberMe.toggle().value;
  }

  void disposeLogin() {
    for (var element in [LoginPhoneController, LoginPassController]) {
      element.dispose();
    }
  }

  // reg

  TextEditingController regFristNameController = TextEditingController();
  FocusNode regFristNameFocusNode = FocusNode();
  TextEditingController regLastNameController = TextEditingController();
  FocusNode regLastNameFocusNode = FocusNode();

  TextEditingController regPhoneController = TextEditingController();
  FocusNode regPhoneFocusNode = FocusNode();
  TextEditingController regPassController = TextEditingController();
  FocusNode regPasswordFocusNode = FocusNode();
  TextEditingController regNewPassController = TextEditingController();
  FocusNode regNewPassFocusNode = FocusNode();

  Rx<CountryCode> regSelectCountry = CountryCode.fromDialCode("+20").obs;

  void disposeSignUp() {
    for (var element in [
      regFristNameController,
      regFristNameFocusNode,
      regLastNameController,
      regLastNameFocusNode,
      regPhoneController,
      regPhoneFocusNode,
      regPassController,
      regPasswordFocusNode,
    ]) {
      element.dispose();
    }
  }

  RxBool isLoadingSignUp = false.obs;
  validationSignUp() async {
    if (regFristNameController.text.isEmpty) {
      showCustomSnackBar(Strings.firstNameIsRequired.tr);
    } else if (regLastNameController.text.isEmpty) {
      showCustomSnackBar(Strings.lastNameIsRequired.tr);
    } else if (regPhoneController.text.isEmpty) {
      showCustomSnackBar(Strings.phoneIsRequired.tr);
    } else if (regPhoneController.text.length < 8) {
      showCustomSnackBar(Strings.invalidPhone.tr);
    } else if (regPassController.text.isEmpty) {
      showCustomSnackBar(Strings.passIsRequired.tr);
    } else if (regNewPassController.text.length < 8) {
      showCustomSnackBar(Strings.minPassLength.tr);
    } else if (regNewPassController.text.isEmpty) {
      showCustomSnackBar(Strings.confirmPasswordIsRequired.tr);
    } else if (regPassController.text != regNewPassController.text) {
      showCustomSnackBar(Strings.passwordIsMismatch.tr);
    } else {
      isLoadingSignUp(true);
      HOODRegisterReqModel reqModel = HOODRegisterReqModel(
          countryCode: regSelectCountry.value.dialCode!,
          fName: regFristNameController.text,
          lName: regLastNameController.text,
          password: regPassController.text,
          phone: regPhoneController.text);

      final res = await authCases.register(reqModel);
      isLoadingSignUp(false);
      if (res.data?.isSuccess ?? true) {
        Get.to(() => const AdditionalSignUpScreen());
      }
      // setUserToken(AppConstants.signUpBody).then((value) {
      //   Get.to(const AdditionalSignUpScreen());
      // });
    }
  }

// complete data
  final Rxn<File> _pickedProfileFile = Rxn(null);
  // File? _pickedProfileFile;

  Rxn<File> get getPickedProfileFile => _pickedProfileFile;
  set pickedProfileFile(File file) => _pickedProfileFile.value = file;

  final GlobalKey<FormState> completeValdteKey = GlobalKey<FormState>();
  TextEditingController completeEmailController = TextEditingController();
  FocusNode completeEmailFocusNode = FocusNode();

  TextEditingController addressCompleteController = TextEditingController();
  FocusNode completeAddressFocusNode = FocusNode();

  disposeCompleteData() {
    completeAddressFocusNode.dispose();
    addressCompleteController.dispose();
    completeEmailFocusNode.dispose();
    completeEmailController.dispose();
  }

  RxBool isLoadingCompleteData = false.obs;

  void completeData() {
    
  }

  // forgetPassWord

  TextEditingController forgetPasswordPhoneController = TextEditingController();
  FocusNode forgetPasswordPhoneNode = FocusNode();
  Rx<CountryCode> forgetSelectCountry = CountryCode.fromDialCode("+20").obs;
  final GlobalKey<FormState> forgetPasswordValdteKey = GlobalKey<FormState>();

  void disposeForgetPassScreen() {
    forgetPasswordPhoneController.dispose();
    forgetPasswordPhoneNode.dispose();
  }

  RxBool isForgetPassLoading = false.obs;

  forgetPassClick() async {
    if (!forgetPasswordValdteKey.currentState!.validate()) {
      showCustomSnackBar(Strings.phoneIsRequired.tr);
    } else {
      isForgetPassLoading(true);

      OtpReqModel req = OtpReqModel(
          countryCode: forgetSelectCountry.value.dialCode,
          phone: forgetPasswordPhoneController.text);
      final res = await authCases.forgetPassword(req);
      isForgetPassLoading(false);
      // TODO:

      if (res.data?.isSuccess ?? true) {
        Get.to(() => VerificationScreen(
              otpState: OtpState.forgetPassword,
              number: forgetPasswordPhoneController.text,
            ));
      } else {}
    }
  }

// otp login screen

  TextEditingController phoneControllerForOTPLogInScreen =
      TextEditingController();
  FocusNode nodeForOTPLogInScreen = FocusNode();
  Rx<CountryCode> otpSelectCountry = CountryCode.fromDialCode("+20").obs;

  RxBool otpLoginIsLoading = false.obs;

  // nav to vitrifaction page and put phone
  //

  // VerificationScreen

  RxString updateVerificationCode = ''.obs;

  RxBool isVerificationIsLoading = false.obs;

  // reset- password- screen

  TextEditingController resetOldPasswordController = TextEditingController();
  TextEditingController resetNewPasswordController = TextEditingController();
  TextEditingController resetConfirmPasswordController =
      TextEditingController();

  FocusNode resetOldPasswordFocus = FocusNode();
  FocusNode resetNewPasswordFocusNode = FocusNode();
  FocusNode resetConfirmPasswordFocusNode = FocusNode();

  RxBool resetPassScreenIsLoading = false.obs;

  void disposeResetScreen() {
    resetOldPasswordController.dispose();
    resetNewPasswordController.dispose();
    resetConfirmPasswordController.dispose();
    resetOldPasswordFocus.dispose();
    resetNewPasswordFocusNode.dispose();
    resetConfirmPasswordFocusNode.dispose();
  }

  final GlobalKey<FormState> resetKey = GlobalKey<FormState>();





}
