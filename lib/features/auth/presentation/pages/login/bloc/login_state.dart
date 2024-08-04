part of 'login_bloc.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final Login login;

  const LoginSuccess({required this.login});
}

final class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});
}
