part of 'quiz_bloc.dart';

@immutable
sealed class QuizEvent {}

final class FirstQuestion extends QuizEvent{
  final String quizId;
  FirstQuestion({required this.quizId});
}

final class QuizEnd extends QuizEvent{
  final int score;
  final String quizId;
  QuizEnd({required this.quizId, required this.score});
}