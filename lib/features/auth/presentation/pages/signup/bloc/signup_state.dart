part of 'signup_bloc.dart';

sealed class SignupState {
  const SignupState();
}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final Signup signup;

  const SignupSuccess({required this.signup});
}

final class SignupFailure extends SignupState {
  final String message;

  const SignupFailure({required this.message});
}
