import 'dart:convert';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:ride_sharing_user_app/data/error_response.dart';

import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;

  late String token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token) ?? '';
    if(kDebugMode) {
      print('Token: $token');
    }
    updateHeader(
      token, sharedPreferences.getString(AppConstants.languageCode) ?? '', '0', '0',
    );
  }

  void updateHeader(String token, String? languageCode, String? latitude, String? longitude) {
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.localization: languageCode ?? AppConstants.languages[0].languageCode,
      'Authorization': 'Bearer $token'
    };
    _mainHeaders = header;
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response response = await http.get(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      http.Response response = await http.post(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(String uri, Map<String, String> body, List<MultipartBody> multipartBody, {Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body with ${multipartBody.length} picture');
      }
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(appBaseUrl+uri));
      request.headers.addAll(headers ?? _mainHeaders);
      for(MultipartBody multipart in multipartBody) {
        if(multipart.file != null) {
          Uint8List list = await multipart.file!.readAsBytes();
          request.files.add(http.MultipartFile(
            multipart.key, multipart.file!.readAsBytes().asStream(), list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }
      request.fields.addAll(body);
      http.Response response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      http.Response response = await http.put(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response response = await http.delete(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    // ignore: empty_catches
    }catch(e) {}
    Response localResponse = Response(
      body: body ?? response.body, bodyString: response.body.toString(),
      request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(localResponse.statusCode != 200 && localResponse.body != null && localResponse.body is !String) {
      if(localResponse.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(localResponse.body);
        localResponse = Response(statusCode: localResponse.statusCode, body: localResponse.body, statusText: errorResponse.errors![0].message);
      }else if(localResponse.body.toString().startsWith('{message')) {
        localResponse = Response(statusCode: localResponse.statusCode, body: localResponse.body, statusText: localResponse.body['message']);
      }
    }else if(localResponse.statusCode != 200 && localResponse.body == null) {
      localResponse = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if(kDebugMode) {
      print('====> API Response: [${localResponse.statusCode}] $uri\n${localResponse.body}');
    }
    return localResponse;
  }
}

class MultipartBody {
  String key;
  XFile? file;

  MultipartBody(this.key, this.file);
}
