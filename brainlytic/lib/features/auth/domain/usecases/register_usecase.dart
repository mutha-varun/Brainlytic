import 'package:brainlytic/core/entities/user.dart';
import 'package:brainlytic/core/errors/appfailure.dart';
import 'package:brainlytic/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RegisterUsecase {
  final AuthRepository _authRepository;
  const RegisterUsecase(this._authRepository);

  Future<Either<AppFailure,User>> call({
      required String name,
      required String email,
      required String password
    })async{

    return _authRepository.register(name: name, email: email, password:password);
  
  }
}