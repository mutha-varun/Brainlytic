import 'package:brainlytic/features/home/domain/repository/home_repository.dart';

class StarUsecase {
  final HomeRepository _homeRepository;
  StarUsecase(this._homeRepository);

  Future<Map<String, int>> call({
    required String userId
  }){
    return _homeRepository.getUserStars(userId: userId);
  }
}