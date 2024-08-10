part of 'auth_bloc.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  final Login login;

  const AuthLoginSuccess({required this.login});
}

final class AuthSignupSuccess extends AuthState {
  final Signup signup;

  const AuthSignupSuccess({required this.signup});
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}
