import 'package:bloc/bloc.dart';
import 'package:brainlytic/core/entities/quiz_questions.dart';
import 'package:brainlytic/features/quiz/domain/usecase/first_question_usecase.dart';
import 'package:brainlytic/features/quiz/domain/usecase/update_usecase.dart';
import 'package:meta/meta.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final FirstQuestionUsecase _firstQuestionUsecase;
  final UpdateUsecase _updateUsecase;
  QuizBloc({
    required FirstQuestionUsecase firstQuestionUsecase,
    required UpdateUsecase updateUsecase
  }) : _firstQuestionUsecase = firstQuestionUsecase,
  _updateUsecase = updateUsecase,
  super(QuizInitial()) {

    on<FirstQuestion>((event, emit) async{
      emit(QuizLoading());
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

    on<QuizEnd>((event, emit) async{
      try{
        await _updateUsecase(quizId: event.quizId, score: event.score);
      }catch(e){
        //
      }
    },);
  }
}
