import 'package:auth_flutter/core/errors/failure.dart';
import 'package:auth_flutter/core/network/connection_checker.dart';
import 'package:auth_flutter/core/utils/strings.dart';
import 'package:auth_flutter/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:auth_flutter/features/auth/domain/entities/login.dart';
import 'package:auth_flutter/features/auth/domain/entities/signup.dart';
import 'package:auth_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionChecker,
  });
  @override
  Future<Either<Failure, Login>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Strings.noConnection));
      }
      final login = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return right(login.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Signup>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Strings.noConnection));
      }

      final signup = await remoteDataSource.signup(
        name: name,
        email: email,
        password: password,
      );
      return right(signup.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
