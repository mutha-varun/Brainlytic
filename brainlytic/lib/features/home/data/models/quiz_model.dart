import 'package:brainlytic/core/entities/quiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel extends Quiz{
  const QuizModel({
    required super.color, 
    required super.title, 
    required super.id, 
    required super.totalQuestions,
  });

  factory QuizModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc){
    final data = doc.data();
    return QuizModel(
      color: data['color'] ?? '', 
      title: data['title'] ?? '', 
      id: data['id'] ?? 0, 
      totalQuestions: data['Questions'] ?? 0
    );
  }
}