import 'dart:convert';
import 'package:http/http.dart' as http;
import 'network_enums.dart';
import 'network_typedef.dart';

class NetworkHelper {
  const NetworkHelper._();
  static String concatUrlQP(String url, Map<String, String>? queryParameters) {
    if (url.isEmpty) return url;
    if (queryParameters == null || queryParameters.isEmpty) {
      return url;
    }
    final StringBuffer stringBuffer = StringBuffer("$url?");
    queryParameters.forEach((key, value) {
      if (value.trim() == '') return;
      if (value.contains(' ')) throw Exception('Invalid Input Exception');
      stringBuffer.write('$key=$value&');
    });
    final result = stringBuffer.toString();
    return result.substring(0, result.length - 1);
  }

  static R filterResponse<R>({
    required NetworkCallBack<R> callBack,
    required http.Response? response,
    required NetworkOnFailureCallBackWithMessage<R>
        onFailureCallBackWithMessage,
    CallBackParameterName parameterName = CallBackParameterName.all,
  }) {
    try {
      if (response == null || response.body.isEmpty) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.responseEmpty, 'Empty response');
      }

      var json = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (json != null) {
          return callBack(parameterName.getJson(json));
        }
      } else if (response.statusCode == 1708) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.socket, 'Socket error');
      } else {
        String errorMessage = json != null && json["message"] != null
            ? json["message"]
            : "Unknown error";
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.didNotSucceed, errorMessage);
      }
    } catch (e) {
      return onFailureCallBackWithMessage(
          NetworkResponseErrorType.exception, "$e");
    }

    // Ensure a non-nullable return type
    throw Exception('Unhandled case in filterResponse');
  }
}
