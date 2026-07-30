import 'package:brainlytic/core/entities/quiz.dart';

abstract interface class HomeRepository {
  Future<Map<String, int>> getUserStars({required String userId});

  Future<List<Quiz>> getQuizData({required String userId});
}