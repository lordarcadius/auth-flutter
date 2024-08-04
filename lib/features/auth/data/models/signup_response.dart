import 'dart:convert';

import 'package:auth_flutter/features/auth/domain/entities/signup.dart';

class SignupResponse {
  final String message;
  final bool success;

  SignupResponse({
    required this.message,
    required this.success,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
      };

  SignupResponse signupResponseFromJson(String str) =>
      SignupResponse.fromJson(json.decode(str));

  Signup toEntity() => Signup(
        message: message,
        success: success,
      );

  String signupResponseToJson(SignupResponse data) =>
      json.encode(data.toJson());
}
