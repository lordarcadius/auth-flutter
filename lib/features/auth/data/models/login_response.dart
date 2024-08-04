import 'dart:convert';

import 'package:auth_flutter/features/auth/domain/entities/login.dart';

class LoginResponse extends Login {
  LoginResponse({
    required super.message,
    required super.success,
    required super.token,
    required super.email,
    required super.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'success': success,
      'token': token,
      'email': email,
      'name': name,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      message: map['message'] as String,
      success: map['success'] as bool,
      token: map['token'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
