import 'package:auth_flutter/core/network/api_client.dart';
import 'package:auth_flutter/core/network/network_helper.dart';
import 'package:auth_flutter/core/network/network_service.dart';
import 'package:auth_flutter/core/utils/strings.dart';
import 'package:auth_flutter/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:auth_flutter/features/auth/data/models/login_response.dart';
import 'package:auth_flutter/features/auth/data/models/signup_response.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.post,
      url: ApiClient.baseUrl + ApiClient.login,
      body: {
        "email": email,
        "password": password,
      },
    );
    return NetworkHelper.filterResponse(
      callBack: (json) => LoginResponse.fromJson(json),
      response: response,
      onFailureCallBackWithMessage: (errorType, msg) =>
          throw Exception("${Strings.errorOccured} $errorType - $msg"),
    );
  }

  @override
  Future<SignupResponse> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.post,
      url: ApiClient.baseUrl + ApiClient.signup,
      body: {
        "name": name,
        "email": email,
        "password": password,
      },
    );
    return NetworkHelper.filterResponse(
      callBack: (json) => SignupResponse.fromJson(json),
      response: response,
      onFailureCallBackWithMessage: (errorType, msg) =>
          throw Exception("${Strings.errorOccured} $errorType - $msg"),
    );
  }
}
