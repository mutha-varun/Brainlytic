import 'package:cloud_firestore/cloud_firestore.dart';

class StarModel {
  final int quizId;
  final int star;
  StarModel({
    required this.quizId,
    required this.star
  });

  factory StarModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc){
    final data = doc.data();
    return StarModel(
      quizId: doc['id'] as int, 
      star: doc['stars'] as int, 
    );
  }
}