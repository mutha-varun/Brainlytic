import 'package:brainlytic/core/errors/serverexception.dart';
import 'package:brainlytic/features/home/data/models/star_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatasource {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<StarModel>> getUserStars({
      required String userId,
  }) async {
      try{
          final res = await _firebaseFirestore.collection("userData").
          doc(userId).collection("quizData").get();

          return res.docs.map(StarModel.fromDoc).toList();
      }catch(e){
          throw Serverexception(e.toString());
      }
  }
  
  Future<QuerySnapshot<Map<String, dynamic>>> getQuizData(){
    try{
      final res = _firebaseFirestore.collection("quizzes").get();
      return res;
    }catch(e){
      throw Serverexception(e.toString());
    } 
  }

  Future<void> updateQuizStar({
    required String userId,
    required int quizId
  }) async{

  }
}