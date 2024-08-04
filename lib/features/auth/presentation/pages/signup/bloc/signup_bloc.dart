import 'dart:async';

import 'package:auth_flutter/core/params/signup_params.dart';
import 'package:auth_flutter/features/auth/domain/entities/signup.dart';
import 'package:auth_flutter/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserSignup userSignup;
  SignupBloc({required this.userSignup}) : super(SignupInitial()) {
    on<SignupEvent>((event, emit) => emit(SignupLoading()));
    on<SignupRequest>(_onSignup);
  }

  Future<void> _onSignup(SignupRequest event, Emitter<SignupState> emit) async {
    final response = await userSignup(SignupParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    response.fold(
      (failure) => emit(SignupFailure(message: failure.message)),
      (success) {
        emit(SignupSuccess(signup: success));
      },
    );
  }
}
