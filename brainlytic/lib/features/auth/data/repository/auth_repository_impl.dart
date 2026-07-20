import 'package:brainlytic/core/errors/appfailure.dart';
import 'package:brainlytic/core/errors/serverexception.dart';
import 'package:brainlytic/features/auth/data/datasources/firebase_auth_datasources.dart';
import 'package:brainlytic/features/auth/data/model/user_model.dart';
import 'package:brainlytic/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository{

  final FirebaseAuthDatasources _authDatasources;

  AuthRepositoryImpl(this._authDatasources);

  @override
  Stream<UserModel?> get authStateChanges {
    return _authDatasources.authStateChanges.map(
      (user){
        if(user==null) return null;

        return UserModel(id: user.uid, email: user.email!, name: user.displayName!);
      }
    );
  }

  @override
  Future<Either<AppFailure, UserModel>> login({
    required String email, 
    required String password
  }) async{
    try{
      final user = await _authDatasources.loginWithEmailPassword(email: email, password: password);

      return Right(user);
    }on Serverexception catch(e){
      return Left(AppFailure(e.message));
    }
    on FirebaseAuthException catch(e){
      return Left(AppFailure(e.message!));
    }
  }

  @override
  Future<Either<AppFailure, UserModel>> register({
    required String name, 
    required String email, 
    required String password
  }) async {
    try{
      final user = await _authDatasources.registerWithEmailPassword(name: name,email: email, password: password);

      return Right(user);
    }on Serverexception catch(e){
      return Left(AppFailure(e.message));
    }
    on FirebaseAuthException catch(e){
      return Left(AppFailure(e.message!));
    }
  }

  @override
  Future<void> signOut() => _authDatasources.signOut();

}