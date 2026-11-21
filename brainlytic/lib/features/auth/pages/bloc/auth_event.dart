part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginEvent extends AuthEvent{
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password
  });
}

final class RegisterEvent extends AuthEvent{
  final String name;
  final String email;
  final String password;

  RegisterEvent({
    required this.name, 
    required this.email, 
    required this.password
  });
  
}

final class GoogleSigninEvent extends AuthEvent{}

final class GithubSigninEvent extends AuthEvent{}

final class ResetPasswordEvent extends AuthEvent{
  final String email;
  ResetPasswordEvent({
    required this.email
  });
}

final class SignoutEvent extends AuthEvent{}



