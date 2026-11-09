import 'package:bloc/bloc.dart';
import 'package:brainlytic/core/entities/quiz_questions.dart';
import 'package:brainlytic/features/quiz/domain/usecase/first_question_usecase.dart';
import 'package:meta/meta.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final FirstQuestionUsecase _firstQuestionUsecase;
  QuizBloc({
    required FirstQuestionUsecase firstQuestionUsecase
  }) : _firstQuestionUsecase = firstQuestionUsecase,
  super(QuizInitial()) {
    on<QuizEvent>((event, emit) {
      emit(QuizLoading());
    });

    on<FirstQuestion>((event, emit) async{
      try{
        final res =  await _firstQuestionUsecase(quizId: event.quizId);

        res.fold(
          (l)=>emit(QuizFetchError(l.message)),
          (r)=>emit(QuizFetched(questions: r)),
        );
      } catch (e){
        emit(QuizFetchError(e.toString()));
      }
    },);
  }
}
