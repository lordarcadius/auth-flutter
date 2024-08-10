import 'package:auth_flutter/core/errors/failure.dart';
import 'package:auth_flutter/features/auth/domain/entities/login.dart';
import 'package:auth_flutter/features/auth/domain/entities/signup.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, Login>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Signup>> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, Login>> session();
}
