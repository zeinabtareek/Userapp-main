import 'package:country_code_picker/country_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/view/screens/auth/model/sign_up_body.dart';
import 'package:ride_sharing_user_app/view/screens/auth/repository/auth_repo.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/bottom_menu_controller.dart';
import 'package:ride_sharing_user_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_snackbar.dart';

import '../../../../helper/display_helper.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/app_strings.dart';
import '../additional_sign_up_screen.dart';
import '../sign_in_screen.dart';

class AuthController extends GetxController  {//implements GetxService
  final AuthRepo authRepo;
  AuthController({required this.authRepo});
  static AuthController get to => Get.find();

  bool? _isLoading = false;
  bool _acceptTerms = false;

  bool? get isLoading => _isLoading;
  bool get acceptTerms => _acceptTerms;


  final String _mobileNumber = '';
  String get mobileNumber => _mobileNumber;

  XFile? _pickedProfileFile ;
  XFile? get pickedProfileFile => _pickedProfileFile;

  XFile? _pickedIdentityImageFront ;
  XFile? get pickedIdentityImageFront => _pickedIdentityImageFront;
  XFile? _pickedIdentityImageBack ;
  XFile? get pickedIdentityImageBack => _pickedIdentityImageBack;


  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupPhoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();

  TextEditingController signInPhoneController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();

  TextEditingController forgetPasswordPhoneController = TextEditingController();
  TextEditingController changePasswordPhoneController = TextEditingController();
  TextEditingController resetConfirmPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();
  // TextEditingController = TextEditingController();




  FocusNode fNameNode = FocusNode();
  FocusNode lNameNode = FocusNode();
  FocusNode signupPhoneNode = FocusNode();
  FocusNode signInPhoneNode = FocusNode();
  FocusNode forgetPasswordPhoneNode = FocusNode();
  FocusNode changePasswordPhoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode signInpasswordNode = FocusNode();
  FocusNode signInPasswordNode = FocusNode();
  FocusNode signupConfirmPasswordNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode oldPasswordFocus = FocusNode();
  FocusNode identityNumberNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode resetConfirmPasswordFocusNode = FocusNode();
  FocusNode resetPasswordFocusNode = FocusNode();

  String _verificationCode = '';
  String _otp = '';
  String get otp => _otp;
  String get verificationCode => _verificationCode;

  String countryDialCode = CountryCode.fromCountryCode("BD").dialCode??'';

   TextEditingController phoneControllerForOTPLogInScreen = TextEditingController();
  FocusNode nodeForOTPLogInScreen = FocusNode();
  @override
  void onInit() {
    phoneControllerForOTPLogInScreen.text = countryDialCode;
    Get.lazyPut(() => AuthController(authRepo: AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find())));

    super.onInit();
  }


  void pickImage(bool isBack, bool isProfile) async {
    if(isBack){
      _pickedIdentityImageBack = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    }else if(isProfile){
      _pickedProfileFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    } else{
      _pickedIdentityImageFront = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    }
    update();
  }

  Future<void> login(String phone, String password) async {
    _isLoading = true;
    update();
    _navigateLogin(phone,password);
    _isLoading = false;
    update();

  }



  onCountryChanged (CountryCode countryCode , TextEditingController valueController) {//onInit
  countryDialCode = countryCode.dialCode.toString();
  valueController.text = countryDialCode;
  // signInPhoneController.text = countryDialCode;
  }



  Future<void> register(SignUpBody signUpBody) async {
  }

  _navigateLogin(String phone, String password){
    if (_isActiveRememberMe) {
      saveUserNumberAndPassword(phone, password);
    } else {
      clearUserNumberAndPassword();
    }
    Get.find<BottomMenuController>().resetNavBar();
    Get.offAll(()=>   DashboardScreen());
  }

  Future<void> forgetPassword() async {
    _isLoading = true;
    update();
    Response? response = await authRepo.forgetPassword("_numberWithCountryCode");
    if (response!.body['response_code'] == 'default_200') {
      _isLoading = false;
      customSnackBar('successfully_sent_otp'.tr, isError: false);
    }else{
      _isLoading = false;
      customSnackBar('invalid_number'.tr);
    }
    update();
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  Future<void> verifyToken(String phoneOrEmail) async {
    //Response? response = await authRepo.verifyToken(phoneOrEmail, _verificationCode);

    _isLoading = false;
    update();
  }

  Future<void> resetPassword(String phoneOrEmail) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.resetPassword(_mobileNumber, _otp, "newPasswordController.value.text", "confirmNewPasswordController.value.text");
    if (response!.body['response_code'] == 'default_password_reset_200') {

      customSnackBar('password_change_successfully'.tr, isError: false);
    }else{
      customSnackBar(response.body['message']);
    }
    _isLoading = false;
    update();
  }



  void updateVerificationCode(String query) {
    _verificationCode = query;
    if(_verificationCode.isNotEmpty){
      _otp = _verificationCode;
    }
    update();
  }


  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  void setRememberMe() {
    _isActiveRememberMe = true;
    update();
  }


  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future <bool> clearSharedData() async {
    return authRepo.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserCountryCode() {
    return authRepo.getUserCountryCode();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }
  bool isNotificationActive() {
    return authRepo.isNotificationActive();

  }
  toggleNotificationSound(){
    authRepo.toggleNotificationSound(!isNotificationActive());
    update();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }
  Future <void> setUserToken(String token) async{
    authRepo.saveUserToken(token);
  }

  validationLoginPress( ){
    if(signInPhoneController.text.length<8){
      showCustomSnackBar(Strings.invalidPhone.tr);
    }else if(signInPasswordController.text.isEmpty){
      showCustomSnackBar(Strings.passIsRequired.tr);
    }else if(signInPasswordController.text.length<8){
      showCustomSnackBar(Strings.minimumPassLength.tr);
    }else{
       setUserToken(AppConstants.token).then((value){
        login(signInPhoneController.text, signInPasswordController.text);
      });
     }
    }

  confirmPassValidation()async{


    //
    if(resetPasswordController.text.isEmpty){
      showCustomSnackBar(Strings.passIsRequired.tr);
    }else if(resetPasswordController.text.length<8){
      showCustomSnackBar(Strings.minPassLength.tr);
    }else if(resetConfirmPasswordController.text.isEmpty){
      showCustomSnackBar(Strings.confirmPasswordIsRequired.tr);
    }else if(resetPasswordController.text != resetConfirmPasswordController.text){
      showCustomSnackBar(Strings.passwordIsMismatch.tr);
    }
    else{
      showCustomSnackBar(Strings.passwordResetSuccessfully.tr, isError: false);
      Get.offAll(()=>   SignInScreen());
    }
  }

  validationSignUp()async{
    if( fNameController.text.isEmpty){
      showCustomSnackBar(Strings.firstNameIsRequired.tr);
    }
    else
    if( lNameController.text.isEmpty){
      showCustomSnackBar(Strings.lastNameIsRequired.tr);
    }else if(signupPhoneController.text.isEmpty){
      showCustomSnackBar(Strings.phoneIsRequired.tr);
    }else if(signupPhoneController.text.length<8){
      showCustomSnackBar(Strings.invalidPhone.tr);
    }else if(signupPasswordController.text.isEmpty){
      showCustomSnackBar(Strings.passIsRequired.tr);
    }else if(confirmPasswordController.text.length<8){
      showCustomSnackBar(Strings.minPassLength.tr);
    }else if(confirmPasswordController.text.isEmpty){
      showCustomSnackBar(Strings.confirmPasswordIsRequired.tr);
    }else if(signupPasswordController.text != confirmPasswordController.text){
      showCustomSnackBar(Strings.passwordIsMismatch.tr);
    }
    else{
      SignUpBody signUpBody = SignUpBody(
          fName: fNameController.text,
          lName: lNameController.text,
          phone: signupPhoneController.text,
          password: signupPasswordController.text,
          confirmPassword:  confirmPasswordController.text
      );
      if (kDebugMode) {
        print(signUpBody);
      }  setUserToken(AppConstants.signUpBody).then((value){
        Get.to(const AdditionalSignUpScreen());
      });

    }
  }

  }