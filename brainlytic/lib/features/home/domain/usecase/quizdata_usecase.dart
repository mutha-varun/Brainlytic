import 'package:brainlytic/core/entities/quiz.dart';
import 'package:brainlytic/features/home/domain/repository/home_repository.dart';

class QuizdataUsecase {
  final HomeRepository _homeRepository;
  QuizdataUsecase(this._homeRepository);
  Future<List<Quiz>> call({
    required String userId,
  })async{
    return _homeRepository.getQuizData(userId: userId);
  }
}