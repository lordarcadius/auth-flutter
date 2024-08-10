import 'dart:convert';

import 'package:auth_flutter/features/auth/domain/entities/login.dart';

class UserModel {
  final String email;
  final String name;
  final String token;
  UserModel({
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

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      name: map['name'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  Login toEntity() => Login(token: token, email: email, name: name);

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
