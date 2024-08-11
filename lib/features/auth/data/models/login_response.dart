import 'dart:convert';

import 'package:auth_flutter/features/auth/data/models/session_model.dart';
import 'package:auth_flutter/features/auth/domain/entities/login.dart';

class LoginResponse {
  final String message;
  final bool success;
  final String token;
  final String email;
  final String name;

  LoginResponse({
    required this.message,
    required this.success,
    required this.token,
    required this.email,
    required this.name,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        success: json["success"],
        token: json["token"],
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "token": token,
        "email": email,
        "name": name,
      };

  Login toEntity() => Login(
        token: token,
        email: email,
        name: name,
      );

  SessionModel toUser() => SessionModel(
        email: email,
        name: name,
        token: token,
      );

  LoginResponse loginResponseFromJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());
}
