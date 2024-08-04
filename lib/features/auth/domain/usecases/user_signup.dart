import 'package:auth_flutter/core/errors/failure.dart';
import 'package:auth_flutter/core/params/signup_params.dart';
import 'package:auth_flutter/core/usecase/usecase.dart';
import 'package:auth_flutter/features/auth/domain/entities/signup.dart';
import 'package:auth_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements UseCase<Signup, SignupParams> {
  final AuthRepository authRepository;

  UserSignup({required this.authRepository});
  @override
  Future<Either<Failure, Signup>> call(SignupParams params) =>
      authRepository.signup(
        name: params.name,
        email: params.email,
        password: params.password,
      );
}
