import 'package:get/get.dart';

// class TValidator {
//   static String? normalValidator(String? value,
//       {String? hint, bool Function(String)? validate}) {
//     bool showValidate = false;
//     if (validate != null) {
//       showValidate = validate(value!);
//     }
//     if (value == null || value.isEmpty) {
//       return hint ?? tMustHaveValue.tr;
//     } else if (showValidate) {
//       return hint ?? tMustHaveValue.tr;
//     } else {
//       return null;
//     }
//   }

//   static String? egyptianNumberValidator(
//     String? value, {
//     String? hint,
//   }) {
//     return normalValidator(value, hint: tWritePhone.tr, validate: (value) {
//       return !(value.startsWith("01") && value.length == 11);
//     });
//   }

//   static String? confirmPasswordValidate(
//       {required String? value, required String password}) {
//     Print.info('value:: $value  password:: $password');

//     return normalValidator(value, hint: tWrongConfirmedPassword.tr,
//         validate: (value) {
//       return !(value == password);
//     });
//     /* if (value == null || value.isEmpty) {
//       return tMustHaveValue.tr;
//     } else if (!(value == password)) {
//       return tWrongConfirmedPassword.tr;
//     } else {
//       return null;
//     }*/
//   }

//   static String? itemInList(
//       {required String? item, required List<String> list, String hint = ''}) {
//     if (item == null || item.isEmpty) {
//       return '${tYouMustChoose.tr} $hint';
//     } else if (!(list.any((element) => element == item))) {
//       return "wrong choose";
//     } else {
//       return null;
//     }
//   }

//   static String? email(
//     String? value,
//   ) {
//     return normalValidator(value, hint: tWrongEmail.tr, validate: (value) {
//       return !GetUtils.isEmail(value);
//     });
//     /* if (value == null || value.isEmpty) {
//       return tMustHaveValue.tr;
//     } else if (GetUtils.isEmail(value)) {
//       return null;
//     } else {
//       return tWrongEmail.tr;
//     }*/
//   }

//   static String? website(String? value) {
//     if (value != null && value.isNotEmpty) {
//       if (value.startsWith("http") || value.startsWith("https")) {
//         if (!GetUtils.isURL(value)) {
//           return tWrongWebSite.tr;
//         }
//       } else if (!value.startsWith("www.")) {
//         return tWrongWebSite.tr;
//       } else {
//         return null;
//       }
//       return null;
//     }
//     return null;
//   }
// }

class TValidator {
  static String mustWrite = 'MustWrite';
  static const String tMustHaveValue = 'must have value';

  static const String tWrongEmail = 'Wrong Email';
  static const String tWrongConfirmedPassword = 'wrong confirmed password';
  static const String tMustChoose = "Must Choose";

  static const String tThePasswordMustBeAtLeast8CharactersLong =
      "The password must be at least 8 characters long";
  static Map<String, dynamic> arV = {
    tWrongConfirmedPassword: 'كلمة مرور مؤكدة خاطئة',
    tWrongEmail: "بريد الكترونى خاطئي",
    "MustWrite": " من فضلك إكتب",
    "must have value": "يجب أن يكون لها قيمة",
    tThePasswordMustBeAtLeast8CharactersLong: "يجب لا يقل الباسورد عن ٨ خانات",
  };

  static Map<String, dynamic> enV = {
    tWrongEmail: "Wrong Email",
    tWrongConfirmedPassword: 'wrong confirmed password',
    "MustWrite": "You Must Write",
    "must have value": "You Must Write",
    tThePasswordMustBeAtLeast8CharactersLong:
        "The password must be at least 8 characters long",
  };

  static String? names(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    } else {
      return "";
    }
  }

  static String? normalValidator(
    String? value, {
    String? hint,
    bool Function(String)? validate,
  }) {
    bool showValidate = false;
    if (validate != null) {
      showValidate = validate(value!);
    }
    if (value == null || value.isEmpty) {
      return "${mustWrite.tr} ${hint!}";
    } else if (showValidate) {
      return hint ?? tMustHaveValue.tr;
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidate(
      {required String? value,
      required String comparePassword,
      required String? hint}) {
    if (value == null || value.isEmpty) {
      return "${mustWrite.tr} ${hint!}";
    } else if (!(value == comparePassword)) {
      return tWrongConfirmedPassword.tr;
    } else {
      return null;
    }
  }

  static String? email(
    String? value,
    String? hint,
  ) {
    if (value == null || value.isEmpty) {
      return "${mustWrite.tr} ${hint!}";
    } else if (!GetUtils.isEmail(value)) {
      return tWrongEmail.tr;
    } else {
      return null;
    }
  }

  static String? dropDown(
    String? value,
    String? hint,
  ) {
    if (value == null || value.isEmpty) {
      return "${tMustChoose.tr} ${hint!}";
    } else {
      return null;
    }
  }

  // static String? website(String? value) {
  //   if (value != null && value.isNotEmpty) {
  //     if (value.startsWith("http") || value.startsWith("https")) {
  //       if (!GetUtils.isURL(value)) {
  //         return tWrongWebSite.tr;
  //       }
  //     } else if (!value.startsWith("www.")) {
  //       return tWrongWebSite.tr;
  //     } else {
  //       return null;
  //     }
  //     return null;
  //   }
  //   return null;
  // }

  static passwordValidate({required String? value, required String? hint}) {
    if (value == null || value.isEmpty) {
      return "${mustWrite.tr} ${hint!}";
    } else if (!(value.length >= 8)) {
      return tThePasswordMustBeAtLeast8CharactersLong.tr;
    } else {
      return null;
    }
  }
}
