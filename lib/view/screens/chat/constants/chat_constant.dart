import '../../../../util/app_constants.dart';

class ChatConstant {
  static const String _domain = AppConstants.baseUrl;
  static const String _api = 'api';
  static const String _who = 'user';
  static const String who = _who;
  static const String postSendMsg = '$_domain/$_api/$_who/chats';
    static String get getChatComplainLink {
    var url = "api/driver/complain_chat";
    return _domain.endsWith("/") ? '$_domain$url' : '$_domain/$url';
  }
    static String getChatByOrder(String orderId) {
    var url = '$_api/$_who/';
    String link = _domain.endsWith("/") ? '$_domain$url' : '$_domain/$url';
    return "${link}orders/$orderId/chat";
  }
}
