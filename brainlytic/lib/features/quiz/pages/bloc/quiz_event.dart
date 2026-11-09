part of 'quiz_bloc.dart';

@immutable
sealed class QuizEvent {}

final class FirstQuestion extends QuizEvent{
  final String quizId;
  FirstQuestion({required this.quizId});
}