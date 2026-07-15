import 'package:brainlytic/core/errors/serverexception.dart';
import 'package:brainlytic/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;

class FirebaseAuthDatasources {
  final fba.FirebaseAuth _auth = fba.FirebaseAuth.instance;

  Future<UserModel> registerWithEmailPassword({required String name,required String email, required String password}) async{
    try{
      final fba.UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      cred.user!.updateDisplayName(name);
      if(cred.user == null){
        throw Serverexception("User is null");
      }

      var map = {
        "id": cred.user!.uid,
        "email": cred.user!.email,
        "name": cred.user!.displayName,
      };

      return UserModel.fromJson(map);
    }catch(e){
      throw Serverexception(e.toString());
    }
    
  }
  
  Future<fba.UserCredential> loginWithEmailPassword({required String email, required String password}) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }


  Future<void> signOut() => _auth.signOut();

  Stream<fba.User?> get authStateChanges => _auth.authStateChanges();
}