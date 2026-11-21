import 'package:brainlytic/core/entities/quiz.dart';

abstract interface class HomeRepository {
  Future<Map<String, int>> getUserStars();

  Future<List<Quiz>> getQuizData();
}