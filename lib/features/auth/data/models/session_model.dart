import 'dart:convert';

import 'package:auth_flutter/features/auth/domain/entities/login.dart';

class SessionModel {
  final String email;
  final String name;
  final String token;
  SessionModel({
    required this.email,
    required this.name,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'token': token,
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      email: map['email'] as String,
      name: map['name'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  Login toEntity() => Login(token: token, email: email, name: name);

  factory SessionModel.fromJson(String source) =>
      SessionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
