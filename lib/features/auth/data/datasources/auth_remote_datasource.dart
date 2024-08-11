import 'package:auth_flutter/features/auth/data/models/login_response.dart';
import 'package:auth_flutter/features/auth/data/models/signup_response.dart';
import 'package:auth_flutter/features/auth/data/models/session_model.dart';

abstract class AuthRemoteDataSource {
  Future<SignupResponse> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<LoginResponse> login({
    required String email,
    required String password,
  });

  Future<SessionModel> session();
}
