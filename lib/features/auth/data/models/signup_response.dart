import 'dart:convert';

import 'package:auth_flutter/features/auth/domain/entities/signup.dart';

class SignupResponse extends Signup {
  SignupResponse({
    required super.message,
    required super.success,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'success': success,
    };
  }

  factory SignupResponse.fromMap(Map<String, dynamic> map) {
    return SignupResponse(
      message: map['message'] as String,
      success: map['success'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupResponse.fromJson(String source) =>
      SignupResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
