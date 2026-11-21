part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeLoading extends HomeState{}

final class HomeDataFetchSuccess extends HomeState{
  final List<Quiz> quizzes;
  final Map<String, int> stars;
  HomeDataFetchSuccess(this.quizzes, this.stars);
}

final class HomeError extends HomeState{
  final String message;
  HomeError(this.message);
}
