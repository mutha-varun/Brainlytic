import 'package:brainlytic/core/entities/star.dart';
import 'package:brainlytic/features/home/data/models/quiz_model.dart';

class Quiztemplate {
  final int id;
  final String title;
  final String color;
  final int stars;
  final int totalQuestions;

  Quiztemplate({
    required this.id,
    required this.title,
    required this.color,
    required this.stars,
    required this.totalQuestions,
  });
  
  factory Quiztemplate.toMap(QuizModel model, Star stars){
    return Quiztemplate(
      id: model.id, 
      title: model.title, 
      color: model.color, 
      stars: stars.star, 
      totalQuestions: model.totalQuestions
    );
  }
}
