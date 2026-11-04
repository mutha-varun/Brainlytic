import 'package:brainlytic/features/auth/domain/repository/auth_repository.dart';

class SignoutUsecase {

  final AuthRepository _authRepository;
  SignoutUsecase(this._authRepository);

  Future<void> call(){
    return _authRepository.signOut();
  }
}