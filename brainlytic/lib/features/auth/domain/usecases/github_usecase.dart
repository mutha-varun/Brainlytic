import 'package:brainlytic/core/entities/user.dart';
import 'package:brainlytic/core/errors/appfailure.dart';
import 'package:brainlytic/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GithubUsecase {
  final AuthRepository _authRepository;

  GithubUsecase(this._authRepository);

  Future<Either<AppFailure, User>> call()async{
    return await _authRepository.githubSignin();
  }
}