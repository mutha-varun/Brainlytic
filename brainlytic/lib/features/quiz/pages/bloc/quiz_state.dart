part of 'quiz_bloc.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class QuizLoading extends QuizState{}

final class QuizFetched extends QuizState{
  final List<QuizQuestions> questions;
  QuizFetched({required this.questions});
}

final class QuizFetchError extends QuizState{
  final String message;
  QuizFetchError(this.message);
}
