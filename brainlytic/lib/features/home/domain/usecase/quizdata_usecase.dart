import 'package:brainlytic/features/home/data/models/quiz_model.dart';
import 'package:brainlytic/features/home/domain/repository/home_repository.dart';

class QuizdataUsecase {
  final HomeRepository _homeRepository;
  QuizdataUsecase(this._homeRepository);
  Future<List<QuizModel>> call({
    required String userId,
  })async{
    return _homeRepository.getQuizData(userId: userId);
  }
}