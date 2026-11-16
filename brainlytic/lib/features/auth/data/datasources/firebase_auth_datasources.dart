import 'package:brainlytic/core/errors/serverexception.dart';
import 'package:brainlytic/features/auth/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        throw const Serverexception("User data cannot be created");
      }

      var map = {
        "id": cred.user!.uid,
        "email": cred.user!.email,
        "name": cred.user!.displayName,
      };

      return UserModel.fromMap(map);
    }catch(e){
      throw Serverexception(e.toString());
    }
  }

  Future<UserModel> singinWithGoogle() async{
    try{
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      final authorizationClient = googleUser.authorizationClient;
      GoogleSignInClientAuthorization? authorization =
      await authorizationClient.authorizationForScopes([
        'email',
        'profile',
      ]);
      authorization ??= await authorizationClient.authorizeScopes(['email', 'profile']);

      final accessToken = authorization.accessToken;
      final credential = fba.GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken
      );

      final cred = await _auth.signInWithCredential(credential);
      
      if(cred.user == null){
        throw const Serverexception("User not found");
      }

      if(cred.additionalUserInfo?.isNewUser ?? false){
        final res = await createUserData(uid: cred.user!.uid);

        if(!res){
          throw const Serverexception("User data cannot be created");
        }
      }

      var map = {
       "id": cred.user!.uid,
        "email": cred.user!.email,
        "name": cred.user!.displayName,
      };

      return UserModel.fromMap(map);

    } catch(e){
      throw Serverexception(e.toString());
    }
  }

  Future<UserModel> signinWithGithub()async{
    try{

      fba.GithubAuthProvider githubAuthProvider = fba.GithubAuthProvider();
      late final fba.UserCredential cred;
      if(kIsWeb){
        cred = await fba.FirebaseAuth.instance.signInWithPopup(githubAuthProvider);
      }
      else{
        cred = await fba.FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
      }

      if(cred.user == null){
        throw const Serverexception("User not found");
      }

      if(cred.additionalUserInfo?.isNewUser ?? false){
        final res = await createUserData(uid: cred.user!.uid);

        if(!res){
          throw const Serverexception("User data cannot be created");
        }
      }

      var map = {
       "id": cred.user!.uid,
        "email": cred.user!.email,
        "name": cred.user!.displayName,
      };

      return UserModel.fromMap(map);
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

      return UserModel.fromMap(map);

    }catch(e){
      throw Serverexception(e.toString());
    }
  }

  Future<String> resetPassword({
    required String email
  })async{
    try {
      await _auth.sendPasswordResetEmail(
        email: email
      );
      return "Email sent successfully";
    } catch(e){
      throw Serverexception(e.toString());
    }
  }

  Future<void> signOut() => _auth.signOut();

  Stream<fba.User?> get authStateChanges => _auth.authStateChanges();
}