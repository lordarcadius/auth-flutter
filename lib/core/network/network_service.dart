import 'dart:convert';
import 'package:auth_flutter/core/di/init_dependencies.dart';
import 'package:auth_flutter/core/utils/session_manager.dart';
import 'package:http/http.dart' as http;

import 'network_helper.dart';

enum RequestType { get, put, post }

class NetworkService {
  const NetworkService._();

  static Map<String, String> _getHeaders(bool setToken) => {
        'Content-Type': 'application/json',
        'Authorization': setToken
            ? serviceLocator<UserSessionManager>().getUser()?.token ?? ''
            : ''
      };

  static Future<http.Response>? _createRequest({
    required RequestType requestType,
    required Uri uri,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    if (requestType == RequestType.get) {
      return http.get(uri, headers: headers);
    } else if (requestType == RequestType.post) {
      return http.post(uri, headers: headers, body: jsonEncode(body));
    }
    return null;
  }

  static Future<http.Response?>? sendRequest(
      {required RequestType requestType,
      required String url,
      Map<String, dynamic>? body,
      Map<String, String>? queryParam,
      bool setToken = false}) async {
    try {
      final header = _getHeaders(setToken);
      final apiUrl = NetworkHelper.concatUrlQP(url, queryParam);

      final response = await _createRequest(
        requestType: requestType,
        uri: Uri.parse(apiUrl),
        headers: header,
        body: body,
      );
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
}
