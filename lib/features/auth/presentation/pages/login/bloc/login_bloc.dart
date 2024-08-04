import 'dart:async';

import 'package:auth_flutter/core/params/login_params.dart';
import 'package:auth_flutter/features/auth/domain/entities/login.dart';
import 'package:auth_flutter/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserLogin userLogin;
  LoginBloc({required this.userLogin}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) => emit(LoginLoading()));
    on<LoginRequest>(_onLogin);
  }

  Future<void> _onLogin(LoginRequest event, Emitter<LoginState> emit) async {
    final response = await userLogin(
        LoginParams(email: event.email, password: event.password));

    response.fold(
      (failure) => emit(LoginFailure(message: failure.message)),
      (success) {
        //TODO: Store login state here in secure shared prefs
        emit(LoginSuccess(login: success));
      },
    );
  }
}
