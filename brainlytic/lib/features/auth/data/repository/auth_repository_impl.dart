import 'package:brainlytic/features/auth/data/datasources/firebase_auth_datasources.dart';
import 'package:brainlytic/features/auth/domain/model/user_model.dart';
import 'package:brainlytic/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{

  final FirebaseAuthDatasources _authDatasources;

  AuthRepositoryImpl(this._authDatasources);

  @override
  Stream<UserModel?> get authStateChanges {
    return _authDatasources.authStateChanges.map(
      (user){
        if(user==null) return null;

        return UserModel(id: user.uid, email: user.email!);
      }
    );
  }

  @override
  Future<UserModel> login(String email, String password) async{
    final cred = await _authDatasources.loginWithEmailPassword(email: email, password: password);

    return UserModel(id: cred.user!.uid, email: cred.user!.email!);
    
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final cred = await _authDatasources.registerWithEmailPassword(email: email, password: password);

    return UserModel(id: cred.user!.uid, email: cred.user!.email!);
  }

  @override
  Future<void> signOut() => _authDatasources.signOut();

}