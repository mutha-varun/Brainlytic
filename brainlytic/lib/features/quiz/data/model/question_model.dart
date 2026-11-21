import 'package:brainlytic/core/entities/quiz_questions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel extends QuizQuestions{
  QuestionModel({
    required super.question, 
    required super.options, 
    required super.answerIndex
  });

  factory QuestionModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc){
    return QuestionModel(
      question: doc["question"], 
      options: List<String>.from(doc["options"] as List), 
      answerIndex: doc["answerIndex"]
    );
  }
}