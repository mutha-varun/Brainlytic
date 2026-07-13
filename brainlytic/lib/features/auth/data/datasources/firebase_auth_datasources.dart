import 'package:firebase_auth/firebase_auth.dart' as fba;

class FirebaseAuthDatasources {
  final fba.FirebaseAuth _auth = fba.FirebaseAuth.instance;

  Future<fba.UserCredential> registerWithEmailPassword({required String email, required String password}) {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
    
  }

  
  Future<fba.UserCredential> loginWithEmailPassword({required String email, required String password}) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }


  Future<void> signOut() => _auth.signOut();

  Stream<fba.User?> get authStateChanges => _auth.authStateChanges();
}