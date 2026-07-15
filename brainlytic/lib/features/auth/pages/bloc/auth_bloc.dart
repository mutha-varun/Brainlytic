import 'package:brainlytic/core/entities/user.dart';
import 'package:brainlytic/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> { 

  final RegisterUsecase _registerUsecase;

  AuthBloc({
    required RegisterUsecase registerUsecase
  }) : 
  _registerUsecase = registerUsecase,
  super(AuthInitial()) {
    on<AuthEvent>((_, emit) =>emit(AuthLoading()));

    // on<Login>((event, emit) async {

    //   final res = await 

    //   res.fold
    //   emit(AuthSuccess());
    // });

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
  }
}
