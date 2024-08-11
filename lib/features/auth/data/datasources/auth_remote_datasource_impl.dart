import 'dart:convert';
import 'package:auth_flutter/core/network/api_client.dart';
import 'package:auth_flutter/core/network/network_helper.dart';
import 'package:auth_flutter/core/network/network_service.dart';
import 'package:auth_flutter/core/utils/constants.dart';
import 'package:auth_flutter/core/utils/prefs.dart';
import 'package:auth_flutter/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:auth_flutter/features/auth/data/models/login_response.dart';
import 'package:auth_flutter/features/auth/data/models/signup_response.dart';
import 'package:auth_flutter/features/auth/data/models/session_model.dart';

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
      onFailureCallBackWithMessage: (errorType, msg) => throw "$msg",
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
      onFailureCallBackWithMessage: (errorType, msg) => throw "$msg",
    );
  }

  @override
  Future<SessionModel> session() async {
    final data = await Prefs.readSecureData(key: Constants.KEY_STORE);
    final user = SessionModel.fromJson(jsonDecode(data));

    await Future.delayed(const Duration(seconds: 2));

    return user;
  }
}
