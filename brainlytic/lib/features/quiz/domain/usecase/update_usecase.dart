import 'package:brainlytic/features/quiz/domain/repository/quiz_repository.dart';

class UpdateUsecase {
  final QuizRepository _quizRepository;
  UpdateUsecase(this._quizRepository);

  Future<void> call({required String quizId, required int score}){
    return _quizRepository.update(quizId: quizId, score: score);
  }
}