import 'dart:convert';
import 'package:http/http.dart' as http;

import 'network_helper.dart';

enum RequestType { get, put, post }

class NetworkService {
  const NetworkService._();

  static Map<String, String> _getHeaders() => {
        'Content-Type': 'application/json',
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

  static Future<http.Response?>? sendRequest({
    required RequestType requestType,
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? queryParam,
  }) async {
    try {
      final header = _getHeaders();
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
