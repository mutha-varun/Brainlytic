import 'package:brainlytic/core/entities/quiz_questions.dart';
import 'package:brainlytic/core/errors/appfailure.dart';
import 'package:brainlytic/features/quiz/domain/repository/quiz_repository.dart';
import 'package:fpdart/fpdart.dart';

class FirstQuestionUsecase {
  final QuizRepository _quizRepository;
  FirstQuestionUsecase(this._quizRepository);
  Future<Either<AppFailure, List<QuizQuestions>>> call({required String quizId}){
    return _quizRepository.fetch(quizId: quizId);
  }
}