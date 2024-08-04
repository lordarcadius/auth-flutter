import 'package:auth_flutter/core/errors/failure.dart';
import 'package:auth_flutter/core/params/login_params.dart';
import 'package:auth_flutter/core/usecase/usecase.dart';
import 'package:auth_flutter/features/auth/domain/entities/login.dart';
import 'package:auth_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<Login, LoginParams> {
  final AuthRepository authRepository;

  UserLogin({required this.authRepository});
  @override
  Future<Either<Failure, Login>> call(LoginParams params) =>
      authRepository.login(
        email: params.email,
        password: params.password,
      );
}
