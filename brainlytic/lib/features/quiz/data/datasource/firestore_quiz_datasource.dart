import 'package:brainlytic/core/errors/appfailure.dart';
import 'package:brainlytic/core/errors/serverexception.dart';
import 'package:brainlytic/features/quiz/data/model/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class FirestoreQuizDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Either<AppFailure,List<QuestionModel>>> fetch({required String quizId}) async {
    try{
      final res = await _firestore.collection("quizzes").doc("quiz$quizId").collection("questions").get();
      
      return Right(res.docs.map(QuestionModel.fromDoc).toList());
    }catch(e){
      return Left(AppFailure(e.toString()));
    }
  }

  Future<void> update({required String quizId,required int score}) async{
    try{
      final userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('userData').
      doc(userId)
      .collection('quizData')
      .doc("quiz$quizId")
      .update({
        'stars': score,
      });

    }catch(e){
      throw Serverexception(e.toString());
    }
  }
}
