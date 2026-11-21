
import 'package:brainlytic/core/errors/appfailure.dart';
import 'package:brainlytic/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ResetpasswordUsecase {
    final AuthRepository _authRepository;
    ResetpasswordUsecase(this._authRepository);

    Future<Either<AppFailure, String>> call({required String email})async{
        return await _authRepository.resetPassword(email: email);
    }
}