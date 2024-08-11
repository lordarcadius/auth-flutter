import 'dart:async';

import 'package:auth_flutter/core/di/init_dependencies.dart';
import 'package:auth_flutter/core/params/login_params.dart';
import 'package:auth_flutter/core/params/signup_params.dart';
import 'package:auth_flutter/core/usecase/usecase.dart';
import 'package:auth_flutter/core/utils/session_manager.dart';
import 'package:auth_flutter/features/auth/domain/entities/login.dart';
import 'package:auth_flutter/features/auth/domain/entities/signup.dart';
import 'package:auth_flutter/features/auth/domain/usecases/user_login.dart';
import 'package:auth_flutter/features/auth/domain/usecases/user_session.dart';
import 'package:auth_flutter/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin userLogin;
  final UserSignup userSignup;
  final UserSession userSession;

  AuthBloc({
    required this.userLogin,
    required this.userSignup,
    required this.userSession,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<AuthLogin>(_onLogin);
    on<AuthSignup>(_onSignup);
    on<AuthIsUserLoggedIn>(_onValidateUser);
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final response = await userLogin(
        LoginParams(email: event.email, password: event.password));

    response.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (success) {
        final session = serviceLocator<UserSessionManager>();
        session.setUser(success);
        emit(AuthLoginSuccess(login: success));
      },
    );
  }

  Future<void> _onSignup(AuthSignup event, Emitter<AuthState> emit) async {
    final response = await userSignup(SignupParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    response.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (success) {
        emit(AuthSignupSuccess(signup: success));
      },
    );
  }

  Future<void> _onValidateUser(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final response = await userSession(NoParams());

    response.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (success) {
        final session = serviceLocator<UserSessionManager>();
        session.setUser(success);
        emit(AuthLoginSuccess(login: success));
      },
    );
  }
}
