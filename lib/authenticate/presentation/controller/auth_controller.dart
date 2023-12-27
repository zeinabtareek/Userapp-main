import 'dart:async';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../bases/base_controller.dart';
import '../../../helper/display_helper.dart';
import '../../../initialize_dependencies.dart';
import '../../../util/app_strings.dart';
import '../../../view/screens/dashboard/bottom_menu_controller.dart';
import '../../../view/screens/dashboard/dashboard_screen.dart';
import '../../../view/screens/html/html_viewer_screen.dart';
import '../../config/config.dart';
import '../../data/models/base_model.dart';
import '../../data/models/base_phone_req_model.dart';
import '../../data/models/req-model/change_password_req_model.dart';
import '../../data/models/req-model/complete_data_req_model.dart';
import '../../data/models/req-model/login_with_otp_model.dart';
import '../../data/models/req-model/login_with_pass_req_model.dart';
import '../../data/models/req-model/register_req_model.dart';
import '../../data/models/req-model/update_password_req_model.dart';
import '../../data/models/req-model/verify_phone_req_model.dart';
import '../../data/models/res-models/user_model.dart';
import '../../domain/use-cases/auth_cases.dart';
import '../../enums/auth_enums.dart';
import '../../helper/helper.dart';
import '../complete-data-screen/complete_data_screen.dart';
import '../forgot_password/forget_password_screen.dart';
import '../login-with-otp/otp_log_in_screen.dart';
import '../login-with-pass/sign_in_screen.dart';
import '../reset-password-screen/reset_password_screen.dart';
import '../sign-up/sign_up_screen.dart';
import '../verfictaion-screen/verification_screen.dart';

const String defaultDailCode = "+966";

class AuthController extends GetxController {
  var authBinding = BindingsBuilder(
    () {
      Get.put(AuthController(sl()));
    },
  );
  toForgetPassScreen() {
    initForgetPassScreen();
    Get.toNamed(AuthScreenPath.forgetPasswordScreenRouteName);
  }

  void _toHomeScreen() {
    Get.find<BottomMenuController>().resetNavBar();
    Get.offAll(() => DashboardScreen(), binding: BindingsBuilder(() {
      Get.lazyPut(() => BaseController()..getUser);
    }));
  }

  toLoginOtpScreen(OtpState otpState) {
    initOtpScreen();
    Get.to(() => const OtpLoginScreen(), binding: authBinding);
  }

  toSignUpScreen() {
    Get.to(() => SignUpScreen(), binding: authBinding);
  }

  toHtmlViewer() {
    Get.to(() => const HtmlViewerScreen());
  }

  toCompleteDataScreen() {
    Get.off(() => const CompleteDataScreen(), binding: authBinding);
  }

  void toSignInScreen() {
    Get.off(
      () => SignInScreen(),
      binding: authBinding,
    );
    initLoginWithPassScreen();
  }

  ///imp use case
  AuthCases authCases;

  AuthController(
    this.authCases,
  );

  @override
  void onClose() {
    disposeCompleteDataScreen();
    disposeForgetPassScreen();
    disposeLogin();
    disposeOtpScreen();
    disposeResetScreen();
    disposeSignUp();
    super.onClose();
  }

  @override
  void onInit() {
    initLoginWithPassScreen();
    initOtpScreen();
    initCompleteDataScreen();
    initResetScreen();
    initVerificationScreen();
    initForgetPassScreen();
    initSignUp();

    super.onInit();
  }

  /// [SignInScreen]

  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController loginPassController = TextEditingController();
  Rx<CountryCode> loginSelectCountry =
      CountryCode.fromDialCode(defaultDailCode).obs;
  GlobalKey<FormState> loginWithPassKey = GlobalKey<FormState>();

  void initLoginWithPassScreen() async {
    loginPhoneController = TextEditingController();
    loginPassController = TextEditingController();
    if (await authCases.isContainsAuthUserData()) {
      LoginWithPassReqModel? req = await authCases.getAuthUserData();
      loginPassController.text = req?.password ?? "";

      loginPhoneController.text =
          req!.phoneReqModel.phoneCode + req.phoneReqModel.phone;
      isLoginRememberMe(true);
    }
  }

  RxBool isLoginWithPassLoading = false.obs;
  RxBool isLoginRememberMe = false.obs;
  void loginWithPass() async {
    if (loginWithPassKey.currentState!.validate()) {
      isLoginWithPassLoading(true);
      var req = LoginWithPassReqModel(
          password: loginPassController.text,
          phoneReqModel: BasePhoneReqModel(
            phone: loginPhoneController.text,
            phoneCode: loginSelectCountry.value.dialCode!,
          ));
      final res = await authCases.loginWithPassword(req);
      isLoginWithPassLoading(false);

      checkStatus(
        res,
        onError: (error) {
          if (error?.data?.status == 403) {
            _toVerificationScreen(
              loginPhoneController.text,
              loginSelectCountry.value.dialCode!,
              OtpState.loginWithOtp,
            );
          }
        },
        onSuccess: (res) async {
          if (isLoginRememberMe.isTrue) {
            await authCases.saveAuthUserData(req);
          } else {
            await authCases.saveAuthUserData(null);
          }

          final UserAuthModel user = res!.user!;

          await authCases.setUserDate(user);
          // Get.find<BaseController>().getUser;
          // TODO:  isNotVerifiedPhone
          print('user complete ration is:::${user.profileCompletedRatio}');
          // TODO:  welcome toast
          _toHomeScreen();
        },
      );
    }
  }

  Future<dynamic>? _toVerificationScreen(
      String phone, String poneCode, OtpState state) {
    return Get.off(
      VerificationScreen(
        number: phone,
        countryCode: poneCode ?? defaultDailCode,
        otpState: state,
      ),
      binding: BindingsBuilder(
        () {
          Get.lazyPut(() => AuthController(sl()));
        },
      ),
    );
  }

  toggleRememberMe() {
    isLoginRememberMe.value = isLoginRememberMe.toggle().value;
  }

  void disposeLogin() {
    for (var element in [loginPhoneController, loginPassController]) {
      element.dispose();
    }
  }

  /// [SignUpScreen]

  TextEditingController regFirstNameController = TextEditingController();
  FocusNode regFirstNameFocusNode = FocusNode();
  TextEditingController regLastNameController = TextEditingController();
  FocusNode regLastNameFocusNode = FocusNode();

  TextEditingController regPhoneController = TextEditingController();
  FocusNode regPhoneFocusNode = FocusNode();
  TextEditingController regPassController = TextEditingController();
  FocusNode regPasswordFocusNode = FocusNode();
  TextEditingController regNewPassController = TextEditingController();
  FocusNode regNewPassFocusNode = FocusNode();

  Rx<CountryCode> regSelectCountry =
      CountryCode.fromDialCode(defaultDailCode).obs;
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  initSignUp() {
    regFirstNameController = TextEditingController();
    regFirstNameFocusNode = FocusNode();
    regLastNameController = TextEditingController();
    regLastNameFocusNode = FocusNode();

    regPhoneController = TextEditingController();
    regPhoneFocusNode = FocusNode();
    regPassController = TextEditingController();
    regPasswordFocusNode = FocusNode();
    regNewPassController = TextEditingController();
    regNewPassFocusNode = FocusNode();
  }

  void disposeSignUp() {
    for (var element in [
      regFirstNameController,
      regFirstNameFocusNode,
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
    if (signUpKey.currentState!.validate()) {
      isLoadingSignUp(true);
      HOODRegisterReqModel reqModel = HOODRegisterReqModel(
        phoneReqModel: BasePhoneReqModel(
            phone: regPhoneController.text,
            phoneCode: regSelectCountry.value.dialCode!),
        fName: regFirstNameController.text,
        lName: regLastNameController.text,
        password: regPassController.text,
      );

      final res = await authCases.register(reqModel);
      isLoadingSignUp(false);
      checkStatus(
        res,
        onSuccess: (res) {
          UserAuthModel user = res!.data!.user!;
          authCases.setUserDate(user);
          // toCompleteDataScreen();
          _toVerificationScreen(
            regPhoneController.text,
            regSelectCountry.value.dialCode!,
            OtpState.register,
          );
        },
      );
    }
  }

  /// [CompleteDataScreen]
  final Rxn<File> _pickedProfileFile = Rxn(null);

  Rxn<File> get getPickedProfileFile => _pickedProfileFile;
  set pickedProfileFile(File file) => _pickedProfileFile.value = file;

  final GlobalKey<FormState> completeValidateKey = GlobalKey<FormState>();
  TextEditingController completeEmailController = TextEditingController();
  FocusNode completeEmailFocusNode = FocusNode();

  TextEditingController addressCompleteController = TextEditingController();
  FocusNode completeAddressFocusNode = FocusNode();
  GlobalKey<FormState> completeDataScreenKey = GlobalKey<FormState>();

  initCompleteDataScreen() {
    completeAddressFocusNode = FocusNode();
    addressCompleteController = TextEditingController();
    completeEmailFocusNode = FocusNode();
    completeEmailController = TextEditingController();
  }

  disposeCompleteDataScreen() {
    completeAddressFocusNode.dispose();
    addressCompleteController.dispose();
    completeEmailFocusNode.dispose();
    completeEmailController.dispose();
  }

  RxBool isLoadingCompleteData = false.obs;

  void completeData() async {
    // if (_pickedProfileFile.value == null) {
    //   // TODO:
    //   showCustomSnackBar(Strings.invalidEmil.tr);
    //   return;
    // }
    if (completeDataScreenKey.currentState!.validate()) {
      isLoadingCompleteData(true);
      final req = CompleteDataReqModel(
        email: completeEmailController.text,
        address: addressCompleteController.text,
        img: _pickedProfileFile.value,
      );
      final res = await authCases.completeData(req);
      isLoadingCompleteData(false);
      checkStatus(
        res,
        onSuccess: (res) async {
          debugPrint(' completeData-- res $res data ${res?.data}');
          String oldUserToken = (await authCases.getUserData())!.tkn;

          await authCases.setUserDate(null);

          UserAuthModel user = res!.data!.user!;
          user = user.copyWith(token: oldUserToken);
          await authCases.setUserDate(user);
          _toHomeScreen();
        },
      );
    }
  }

  /// [ForgotPasswordScreen]

  TextEditingController forgetPasswordPhoneController = TextEditingController();
  FocusNode forgetPasswordPhoneNode = FocusNode();
  Rx<CountryCode> forgetSelectCountry =
      CountryCode.fromDialCode(defaultDailCode).obs;
  final GlobalKey<FormState> forgetPasswordValidateKey = GlobalKey<FormState>();

  void disposeForgetPassScreen() {
    forgetPasswordPhoneController.dispose();
    forgetPasswordPhoneNode.dispose();
  }

  initForgetPassScreen() {
    forgetPasswordPhoneController = TextEditingController();
    forgetPasswordPhoneNode = FocusNode();
  }

  RxBool isForgetPassLoading = false.obs;

  forgetPassClick() async {
    if (!forgetPasswordValidateKey.currentState!.validate()) {
      // showCustomSnackBar(Strings.phoneIsRequired.tr);
      return;
    } else {
      isForgetPassLoading(true);

      BasePhoneReqModel req = BasePhoneReqModel(
          phoneCode: forgetSelectCountry.value.dialCode!,
          phone: forgetPasswordPhoneController.text);
      final res = await authCases.forgetPassword(req);
      isForgetPassLoading(false);

      checkStatus(
        res,
        onSuccess: (res) {
          Get.to(
            () => VerificationScreen(
              otpState: OtpState.forgetPassword,
              number: forgetPasswordPhoneController.text,
              countryCode: forgetSelectCountry.value.dialCode!,
            ),
            binding: authBinding,
          );
        },
      );
    }
  }

  /// [OtpLoginScreen]

  TextEditingController phoneControllerForOTPLogInScreen =
      TextEditingController();
  FocusNode nodeForOTPLogInScreen = FocusNode();
  Rx<CountryCode> otpSelectCountry =
      CountryCode.fromDialCode(defaultDailCode).obs;

  RxBool otpLoginIsLoading = false.obs;
  GlobalKey<FormState> otpScreenKey = GlobalKey<FormState>();

  initOtpScreen() {
    phoneControllerForOTPLogInScreen = TextEditingController();
    nodeForOTPLogInScreen = FocusNode();
    otpSelectCountry = CountryCode.fromDialCode(defaultDailCode).obs;

    otpLoginIsLoading = false.obs;
  }

  void disposeOtpScreen() {
    phoneControllerForOTPLogInScreen.dispose();
    nodeForOTPLogInScreen.dispose();
  }

  void sendOtp() async {
    if (otpScreenKey.currentState!.validate()) {
      otpLoginIsLoading = true.obs;
      final req = BasePhoneReqModel(
        phoneCode: otpSelectCountry.value.dialCode!,
        phone: phoneControllerForOTPLogInScreen.text,
      );
      final res = await authCases
          .sendOtp(req)
          .whenComplete(() => otpLoginIsLoading.value = false);

      checkStatus<MsgModel>(
        showErrorToast: true,
        res,
        onError: (error) {
          // otpLoginIsLoading.value = false;

          // showCustomSnackBar(error?.msg ?? "");
        },
        onSuccess: (res) {
          Get.to(
            () => VerificationScreen(
              countryCode: otpSelectCountry.value.dialCode.toString(),
              number: phoneControllerForOTPLogInScreen.text,
              otpState: OtpState.loginWithOtp,
            ),
            binding: authBinding,
          );
        },
      );
    }
  }

  /// [VerificationScreen]

  RxString updateVerificationCode = ''.obs;

  RxBool isVerificationIsLoading = false.obs;

  RxString min = '00'.obs;
  RxString second = '00'.obs;
  RxBool isCounting = false.obs;

  Timer? countdownTimer;
  Duration waitingDuration = const Duration(seconds: 59);
  TextEditingController otpCodeController = TextEditingController();

  void disposeVerificationScreen() {
    countdownTimer?.cancel();
    waitingDuration = const Duration(seconds: 59);
    isCounting = false.obs;
    isVerificationIsLoading = false.obs;
    otpCodeController.dispose();
  }

  void initVerificationScreen() {
    otpCodeController = TextEditingController();
    countdownTimer?.cancel();
    waitingDuration = const Duration(seconds: 59);
    startTimer();

    isVerificationIsLoading = false.obs;
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    isCounting.value = true;
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    final seconds = waitingDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
      isCounting.value = false;
    } else {
      waitingDuration = Duration(seconds: seconds);
    }
    min.value = waitingDuration.inMinutes.toString().padLeft(2, '0');
    second.value = waitingDuration.inSeconds.toString().padLeft(2, '0');
  }

  reSendMsg(String countryCode, String phone) async {
    isVerificationIsLoading(true);
    var req = BasePhoneReqModel(phoneCode: countryCode, phone: phone);
    final res = await authCases.sendOtp(req);
    isVerificationIsLoading(false);

    checkStatus(
      res,
      onSuccess: (res) {
        showCustomSnackBar(Strings.otpSentSuccessfully.tr, isError: false);
        otpCodeController.clear();
        waitingDuration = const Duration(seconds: 59);
        startTimer();
      },
    );
  }

  checkOtpCode(
    String phone,
    String phoneCode, {
    required Function() onCheckSuccess,
  }) async {
    if (updateVerificationCode.isEmpty ||
        updateVerificationCode.value.length < 4) {
      showCustomSnackBar(Strings.phoneIsRequired.tr);
      return;
    }

    isVerificationIsLoading(true);
    final req = LoginWithOtpReqModel(
        phoneReqModel: BasePhoneReqModel(phone: phone, phoneCode: phoneCode),
        otp: updateVerificationCode.value);

    final res = await authCases.checkOtpCode(req);
    isVerificationIsLoading(false);

    checkStatus(
      res,
      onSuccess: (res) {
        if (res!.stateData!["status"] == true) {
          onCheckSuccess();
        } else {
          // TODO: tell back end to handel msg
          showCustomSnackBar(Strings.invalidOtp.tr, isError: true);
        }
      },
    );
  }

  void verifyPhone(String phone, String phoneCode) async {
    if (updateVerificationCode.isEmpty ||
        updateVerificationCode.value.length < 4) {
      showCustomSnackBar(Strings.phoneIsRequired.tr);
      return;
    }

    isVerificationIsLoading(true);
    final req = VerifyPhoneReqModel(
      phoneReqModel: BasePhoneReqModel(phone: phone, phoneCode: phoneCode),
      phoneConfirmationToken: updateVerificationCode.value,
    );
    final res = await authCases.verifyPhone(req);
    isVerificationIsLoading(false);
    checkStatus(
      res,
      onSuccess: (res) {
        // _toHomeScreen();
        toCompleteDataScreen();
      },
    );
  }

  void loginWithOtp(String phone, String phoneCode) async {
    if (updateVerificationCode.isEmpty ||
        updateVerificationCode.value.length < 4) {
      showCustomSnackBar(Strings.phoneIsRequired.tr);
      return;
    }

    isVerificationIsLoading(true);
    final req = LoginWithOtpReqModel(
      phoneReqModel: BasePhoneReqModel(phone: phone, phoneCode: phoneCode),
      otp: updateVerificationCode.value,
    );
    final res = await authCases.loginWithOtp(req);
    isVerificationIsLoading(false);

    checkStatus(
      res,
      onSuccess: (res) async {
        await authCases.setUserDate(res!.user!);
        // TODO:  welcome toast
        _toHomeScreen();
      },
    );
  }

  /// [ResetPasswordScreen]

  TextEditingController resetOldPasswordController = TextEditingController();
  TextEditingController resetNewPasswordController = TextEditingController();
  TextEditingController resetConfirmPasswordController =
      TextEditingController();

  FocusNode resetOldPasswordFocus = FocusNode();
  FocusNode resetNewPasswordFocusNode = FocusNode();
  FocusNode resetConfirmPasswordFocusNode = FocusNode();

  RxBool resetPassScreenIsLoading = false.obs;

  initResetScreen() {
    resetOldPasswordController = TextEditingController();
    resetNewPasswordController = TextEditingController();
    resetConfirmPasswordController = TextEditingController();

    resetOldPasswordFocus = FocusNode();
    resetNewPasswordFocusNode = FocusNode();
    resetConfirmPasswordFocusNode = FocusNode();

    resetPassScreenIsLoading = false.obs;
  }

  void disposeResetScreen() {
    resetOldPasswordController.dispose();
    resetNewPasswordController.dispose();
    resetConfirmPasswordController.dispose();
    resetOldPasswordFocus.dispose();
    resetNewPasswordFocusNode.dispose();
    resetConfirmPasswordFocusNode.dispose();
  }

  final GlobalKey<FormState> resetKey = GlobalKey<FormState>();

  void resetPass(
    String countryCode,
    String otpCode,
    String phone,
  ) async {
    // if (resetNewPasswordController.text.trim().isEmpty) {
    //   showCustomSnackBar(Strings.passIsRequired.tr);
    //   return;
    // } else if (resetNewPasswordController.text.trim().length < 8) {
    //   showCustomSnackBar(Strings.minPassLength.tr);
    //   return;
    // } else if (resetNewPasswordController.text.trim() !=
    //     resetConfirmPasswordController.text.trim()) {
    //   showCustomSnackBar(Strings.passwordIsMismatch.tr);
    //   return;
    // }

    resetPassScreenIsLoading(true);
    final req = UpdatePasswordReqModel(
      forgetPasswordCode: otpCode,
      password: resetConfirmPasswordController.text,
      phoneReqModel: BasePhoneReqModel(phone: phone, phoneCode: countryCode),
    );
    final res = await authCases.updatePassword(req);
    resetPassScreenIsLoading(false);

    checkStatus(
      res,
      onSuccess: (res) {
        toSignInScreen();
      },
      showSuccessToast: true,
    );
  }

  changePass() async {
    // if (resetNewPasswordController.text.trim().isEmpty ||
    //     resetOldPasswordController.text.trim().isEmpty) {
    //   showCustomSnackBar(Strings.passIsRequired.tr);
    //   return;
    // } else if (resetNewPasswordController.text.trim().length < 8 ||
    //     resetOldPasswordController.text.trim().length < 8) {
    //   showCustomSnackBar(Strings.minPassLength.tr);
    //   return;
    // } else if (resetNewPasswordController.text.trim() !=
    //     resetConfirmPasswordController.text.trim()) {
    //   showCustomSnackBar(Strings.passwordIsMismatch.tr);
    //   return;
    // }
    resetPassScreenIsLoading(true);
    final req = ChangePasswordReqModel(
      oldPass: resetOldPasswordController.text,
      newPass: resetConfirmPasswordController.text,
    );

    final res = await authCases.changePass(req);
    resetPassScreenIsLoading(false);

    checkStatus(
      res,
      onSuccess: (res) async {
        if (await authCases.isContainsAuthUserData()) {
          final authData = await authCases.getAuthUserData();
          authCases.saveAuthUserData(
            authData?.copyWith(password: resetConfirmPasswordController.text),
          );
        }
        Get.back();
      },
      showSuccessToast: true,
    );
  }

  Future logOut() async {
    final res = await authCases.logout();
    checkStatus(
      res,
      onSuccess: (res) {
        toSignInScreen();
      },
      showSuccessToast: true,
    );
  }

  deleteAccount() async {
    final res = await authCases.deleteAcc();
    checkStatus(
      res,
      onSuccess: (res) {
        toSignInScreen();
      },
      showSuccessToast: true,
    );
  }
}
