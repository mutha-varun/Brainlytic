import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel{
  final String color;
  final String title;
  final int id;
  final int totalQuestions;
  const QuizModel({
    required this.color, 
    required this.title, 
    required this.id, 
    required this.totalQuestions,
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