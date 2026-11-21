import 'package:brainlytic/core/entities/user.dart';
import 'package:brainlytic/core/errors/appfailure.dart';
import 'package:brainlytic/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUsecase {
  final AuthRepository _authRepository;

  const LoginUsecase(this._authRepository);
  
  Future<Either<AppFailure, User>> call({
    required String email,
    required String password
  }) async {
    return await _authRepository.login(email: email, password: password);
  }
}