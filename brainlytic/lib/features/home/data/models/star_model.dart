import 'package:brainlytic/core/entities/star.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StarModel extends Star{
  
  StarModel({
    required super.quizId,
    required super.star
  });

  factory StarModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc){
    final data = doc.data();
    return StarModel(
      quizId: doc['id'] as int, 
      star: doc['stars'] as int, 
    );
  }
}