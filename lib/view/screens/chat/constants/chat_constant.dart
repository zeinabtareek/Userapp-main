import '../../../../util/app_constants.dart';

class ChatConstant {
  static const String _domain = AppConstants.baseUrl;
  static const String _api = 'api';
  static const String _who = 'user';
  static const String who = _who;
  static const String postSendMsg = '$_domain/$_api/$_who/chats';
}
