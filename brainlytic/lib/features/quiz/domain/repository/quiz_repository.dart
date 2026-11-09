import 'package:brainlytic/core/entities/quiz_questions.dart';
import 'package:brainlytic/core/errors/appfailure.dart';
import 'package:fpdart/fpdart.dart';

abstract class QuizRepository {
  Future<Either<AppFailure,List<QuizQuestions>>> fetch({required String quizId});
  Future<void> update({required String quizId, required int score});
}
