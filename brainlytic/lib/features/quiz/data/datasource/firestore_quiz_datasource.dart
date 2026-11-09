import 'package:brainlytic/core/errors/appfailure.dart';
import 'package:brainlytic/features/quiz/data/model/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class FirestoreQuizDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<Either<AppFailure,List<QuestionModel>>> fetch({required String quizId}) async {
    try{
      final res = await _firestore.collection("quizzes").doc("quiz$quizId").collection("questions").get();
      
      return Right(res.docs.map(QuestionModel.fromDoc).toList());
    }catch(e){
      debugPrint(e.toString());
      return Left(AppFailure(e.toString()));
      
    }
  }
}
