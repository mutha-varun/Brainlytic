import 'package:brainlytic/core/errors/serverexception.dart';
import 'package:brainlytic/features/auth/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;

class FirebaseAuthDatasources {
  final fba.FirebaseAuth _auth = fba.FirebaseAuth.instance;


  Future<bool> createUserData({required String uid}) async{
    try{
      final user = _auth.currentUser;
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;

      
      await fireStore.collection("userData").doc(uid).set({"uid": uid});
      final length = await fireStore.collection("quizzes").count().get();
      if(length.count is int){
        for(int i=1; i<=(length.count ?? 8); i++){
          await fireStore.collection("userData").doc(uid).
          collection('quizData').doc("quiz$i").set({
            "stars": 0,
            "id": i
          });
        }

        return true;
      }
      
      return false;
      
    }catch(e){
      return false;
    }
  }

  Future<UserModel> registerWithEmailPassword({
    required String name,
    required String email, 
    required String password 
  }) async{
    try{
      final fba.UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      cred.user!.updateDisplayName(name);
      if(cred.user == null){
        throw Serverexception("User not created");
      }

      final res = await createUserData(uid: cred.user!.uid);

      if(!res){
        throw Serverexception("User data cannot be created");
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
  
  Future<UserModel> loginWithEmailPassword({
    required String email, 
    required String password
  }) async {
    try{
      final cred = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );

      if(cred.user == null){
        throw const Serverexception("User not found");
      }

      var map = {
        "id": cred.user!.uid,
        "email": cred.user!.email,
        "name": cred.user!.displayName
      };

      return UserModel.fromJson(map);

    }catch(e){
      throw Serverexception(e.toString());
    }
  }

  Future<void> signOut() => _auth.signOut();

  Stream<fba.User?> get authStateChanges => _auth.authStateChanges();
}