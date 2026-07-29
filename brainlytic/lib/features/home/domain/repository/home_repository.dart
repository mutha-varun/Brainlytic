import 'package:brainlytic/features/home/data/models/quiz_model.dart';

abstract interface class HomeRepository {
  Future<Map<String, int>> getUserStars({required String userId});

  Future<List<QuizModel>> getQuizData({required String userId});
}