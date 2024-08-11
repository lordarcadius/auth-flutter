import 'package:auth_flutter/features/auth/domain/entities/login.dart';

class UserSessionManager {
  static final UserSessionManager _instance = UserSessionManager._internal();

  factory UserSessionManager() {
    return _instance;
  }

  UserSessionManager._internal();

  Login? _user;

  // Setters
  void setUser(Login user) {
    _user = user;
  }

  // Getters
  Login? getUser() => _user;

  // Clear session data
  void clearSession() {
    _user = null;
  }
}
