import 'package:brainlytic/core/entities/user.dart';
import 'package:brainlytic/core/errors/appfailure.dart';
import 'package:brainlytic/features/auth/data/model/user_model.dart';

import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);

  Future<Either<AppFailure, User>> register({
      required String name, 
      required String email, 
      required String password
  });
  
  Future<void> signOut();
  Stream<UserModel?> get authStateChanges;
}