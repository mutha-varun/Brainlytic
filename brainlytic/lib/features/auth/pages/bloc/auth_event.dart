part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class Login extends AuthEvent{

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



