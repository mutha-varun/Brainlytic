import 'package:brainlytic/core/entities/user.dart';
import 'package:brainlytic/features/auth/domain/usecases/github_usecase.dart';
import 'package:brainlytic/features/auth/domain/usecases/google_usecase.dart';
import 'package:brainlytic/features/auth/domain/usecases/login_usecase.dart';
import 'package:brainlytic/features/auth/domain/usecases/register_usecase.dart';
import 'package:brainlytic/features/auth/domain/usecases/resetpassword_usecase.dart';
import 'package:brainlytic/features/auth/domain/usecases/signout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> { 

  final RegisterUsecase _registerUsecase;
  final LoginUsecase _loginUsecase;
  final SignoutUsecase _signoutUsecase;
  final GoogleUsecase _googleUsecase;
  final GithubUsecase _githubUsecase;
  final ResetpasswordUsecase _resetpasswordUsecase;

  AuthBloc({
    required RegisterUsecase registerUsecase,
    required LoginUsecase loginUsecase,
    required SignoutUsecase signoutUsecase,
    required GoogleUsecase googleUsecase,
    required GithubUsecase githubUsecase,
    required ResetpasswordUsecase resetpasswordUsecase
  }) : 
  _registerUsecase = registerUsecase,
  _loginUsecase = loginUsecase,
  _signoutUsecase = signoutUsecase,
  _googleUsecase = googleUsecase,
  _githubUsecase = githubUsecase,
  _resetpasswordUsecase = resetpasswordUsecase,
  super(AuthInitial()) {
    on<AuthEvent>((_, emit) =>emit(AuthLoading()));

    on<RegisterEvent>((event, emit) async {
      final res = await _registerUsecase(
        name: event.name,
        email: event.email,
        password: event.password
      );

      res.fold(
        (l)=>emit(AuthFailure(l.message)), 
        (user)=>emit(AuthSuccess(user))
      );
    });

    on<LoginEvent>((event, emit) async{
      final res = await _loginUsecase(
        email: event.email,
        password: event.password
      );

      res.fold(
        (l)=>emit(AuthFailure(l.message)), 
        (user)=>emit(AuthSuccess(user))
      );
    });

    on<GoogleSigninEvent>((event, emit)async {
      final res = await _googleUsecase();

      res.fold(
        (l)=>emit(AuthFailure(l.message)), 
        (user)=>emit(AuthSuccess(user))
      );
    });

    on<GithubSigninEvent>((event, emit) async{
        final res = await _githubUsecase();

        res.fold(
          (l)=>emit(AuthFailure(l.message)), 
          (user)=>emit(AuthSuccess(user))
        );
    },);

    on<ResetPasswordEvent>((event, emit) async{
      final res = await _resetpasswordUsecase(email: event.email);

      res.fold(
        (l)=>emit(AuthFailure(l.message)), 
        (s)=>emit(ResetPasswordSent(s))
      );
    },);

    on<SignoutEvent>((event, emit) async{
      await _signoutUsecase();
      emit(AuthUnauthenticated());
    },);
  }
}
