import 'package:brainlytic/features/home/domain/repository/home_repository.dart';

class StarUsecase {
  final HomeRepository _homeRepository;
  StarUsecase(this._homeRepository);

  Future<Map<String, int>> call() {
    return _homeRepository.getUserStars();
  }
}