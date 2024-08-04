part of 'signup_bloc.dart';

sealed class SignupEvent {}

final class SignupRequest extends SignupEvent {
  final String name;
  final String email;
  final String password;

  SignupRequest({
    required this.name,
    required this.email,
    required this.password,
  });
}
