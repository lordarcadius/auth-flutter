import 'package:auth_flutter/core/errors/failure.dart';
import 'package:auth_flutter/core/usecase/usecase.dart';
import 'package:auth_flutter/features/auth/domain/entities/login.dart';
import 'package:auth_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSession implements UseCase<Login, NoParams> {
  final AuthRepository authRepository;

  UserSession({required this.authRepository});
  @override
  Future<Either<Failure, Login>> call(NoParams params) =>
      authRepository.session();
}
